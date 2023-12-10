require "set"

grid = []
start = nil

File.foreach("input.txt") do |line|
  line = line.strip.chars
  start = [line.index("S"), grid.length] if line.include?("S")
  grid << line
end

# direction => pipe => [dx, dy, new_direction]
# 0 => north, 1 => east, 2 => south, 3 => west
pipes = {
  0 => { "7" => [-1, 0, 3], "F" => [1, 0, 1],  "|" => [0, -1, 0] },
  1 => { "7" => [0, 1, 2],  "J" => [0, -1, 0], "-" => [1, 0, 1]  },
  2 => { "J" => [-1, 0, 3], "L" => [1, 0, 1],  "|" => [0, 1, 2]  },
  3 => { "L" => [0, -1, 0], "F" => [0, 1, 2],  "-" => [-1, 0, 3] }
}


start_directions = []
(0..3).each do |dir|
  _x, _y = start[0] + [0, 1, 0, -1][dir], start[1] + [-1, 0, 1, 0][dir]

 if _x < grid[0].length && _x >= 0 && _y < grid.length && _y >= 0 && pipes[dir].include?(grid[_y][_x])
   start_directions << dir
 end
end

loop = Set[]
first = true
x, y = start
direction = start_directions[0]
grid[y][x] = %w[| -][direction % 2]

until [x, y] == start && !first
  first = false

  dx, dy, direction = pipes[direction][grid[y][x]]
  x, y = x + dx, y + dy
  loop << [x, y]
end


inners = 0
grid.each_with_index do |row, y|
  row.each_index do |x|
    next if loop.include?([x, y])

    left_parity  = false
    right_parity = false
    (y...grid.length).each do |_y|
      left_parity  = !left_parity  if loop.include?([x, _y]) && %w[- L F].include?(grid[_y][x])
      right_parity = !right_parity if loop.include?([x, _y]) && %w[- J 7].include?(grid[_y][x])
    end

    inners += 1 if left_parity && right_parity
  end
end

puts inners
