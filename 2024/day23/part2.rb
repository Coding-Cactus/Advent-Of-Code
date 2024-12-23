require "set"

def max_clique(clique, remaining_v, exclude_v, graph)
  return clique if remaining_v.empty? and exclude_v.empty?

  max = 0
  max_c = Set[]

  remaining_v.clone.each do |v|
    c = max_clique(clique + [v], remaining_v & graph[v], exclude_v & graph[v], graph)
    if c.length > max
      max_c = c
      max = c.length
    end

    exclude_v << v
    remaining_v.delete(v)
  end

  max_c
end

def solve(lines)
  graph = Hash.new { |h, k| h[k] = Set[] }
  lines.each do |line|
    x, y = line.split("-")
    graph[x] << y
    graph[y] << x
  end

  max_clique(Set[], Set.new(graph.keys), Set[], graph).sort.join(",")
end
