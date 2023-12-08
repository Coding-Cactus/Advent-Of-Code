directions = []
paths = {}
first_line = true

File.foreach("input.txt") do |line|
  next if line == "\n"

  if first_line
    directions = line.strip.chars.map { |c| %w[L R].index(c) }
    first_line = false
  else
    node, options = line.strip.split(" = ")
    options = options.gsub(/[()]/, "").split(", ")

    paths[node] = options
  end
end

i = 0
total = 0
current = "AAA"
until current == "ZZZ"
  current = paths[current][directions[i]]
  i = (i + 1) % directions.length
  total += 1
end

puts total
