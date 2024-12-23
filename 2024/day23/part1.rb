require "set"

def solve(lines)
  graph = Hash.new { |h, k| h[k] = Set[] }
  lines.each do |line|
    x, y = line.split("-")
    graph[x] << y
    graph[y] << x
  end

  triples = Set[]
  graph.each do |source, neighbours|
    next unless source[0] == "t"

    connected = Set[]
    neighbours.each do |n1|
      (graph[n1] & neighbours).each do |n2|
        connected << [source, n1, n2].sort if n1 != n2
      end
    end

    triples |= connected
  end

  triples.length
end
