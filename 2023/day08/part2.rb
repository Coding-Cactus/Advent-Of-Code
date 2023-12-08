directions = []
paths = {}
first_line = true
current = {}
cycles = {}

File.foreach("input.txt") do |line|
  next if line == "\n"

  if first_line
    directions = line.strip.chars.map { |c| %w[L R].index(c) }
    first_line = false
  else
    node, options = line.strip.split(" = ")
    options = options.gsub(/[()]/, "").split(", ")

    paths[node] = options
    if node[-1] == "A"
      current[node] = node
      cycles[node] = 0
    end
  end
end

i = 0
total = 0
until current.empty?
  total += 1

  current.each do |(s_node, c_node)|
    n_node = paths[c_node][directions[i]]

    if n_node[-1] == "Z"
      cycles[s_node] = total
      current.delete(s_node)
    else
      current[s_node] = n_node
    end
  end

  i = (i + 1) % directions.length
end

puts cycles.reduce(1) { |lcm, (_, cycle)| lcm.lcm(cycle) }
