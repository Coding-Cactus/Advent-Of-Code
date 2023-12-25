require "rgl/dijkstra"
require "rgl/adjacency"
require "rgl/traversal"

def solve(lines)
  graph = RGL::AdjacencyGraph.new
  edge_weights = {}

  lines.each do |line|
    component, connected = line.split(": ")
    connected.split.each do |connection|
      graph.add_edge(component, connection)
      edge_weights[[component, connection]] = 1
    end
  end

  a = 1.0
  counts = Hash.new(0)
  graph.vertices.each do |start|
    puts "#{((a / graph.size) * 100).round(2)}%" if a % 10 == 0
    a += 1

    graph.dijkstra_shortest_paths(edge_weights, start).each do |_, path|
      path[...-1].each_with_index { |v, i| counts[[v, path[i+1]].sort] += 1 }
    end
  end

  counts.sort_by { |_, v| v }[-3...].each { |edge, _| graph.remove_edge(*edge) }

  subgraph_size = graph.dfs_iterator.to_a.length
  subgraph_size * (graph.size - subgraph_size)
end
