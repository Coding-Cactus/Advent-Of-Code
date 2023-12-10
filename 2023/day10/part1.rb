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

 if _x < grid[0].length && _x > 0 && _y < grid.length && _y > 0 && pipes[dir].include?(grid[_y][_x])
   start_directions << dir
 end
end

count = 0
x, y = start
direction = start_directions[0]
grid[y][x] = %w[| -][direction % 2]

until [x, y] == start && count != 0
  count += 1

  dx, dy, direction = pipes[direction][grid[y][x]]
  x, y = x + dx, y + dy
end

puts count / 2
