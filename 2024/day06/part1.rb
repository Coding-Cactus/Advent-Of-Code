require 'set'

def next_coord_dir(x, y, dir, obs)
  dirs = [[0, -1], [1, 0], [0, 1], [-1, 0]]

  dx, dy = dirs[dir]
  coord = [x + dx, y + dy]

  while obs.include?(coord)
    dir = (dir + 1) % 4
    dx, dy = dirs[dir]
    coord = [x + dx, y + dy]
  end

  coord + [dir]
end

def solve(lines)
  height = lines.length
  width  = lines[0].length

  x = y = 0
  obstacles = Set[]
  lines.each_with_index do |line, _y|
    line.each_char.with_index do |char, _x|
      obstacles << [_x, _y] if char == "#"
      x, y = _x, _y if char == "^"
    end
  end

  dir = 0
  visited = Set[]
  while x.between?(0, width - 1) && y.between?(0, height - 1)
    visited << [x, y]

    x, y, dir = next_coord_dir(x, y, dir, obstacles)
  end

  visited.length
end
