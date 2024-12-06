require 'set'

$dirs = [[0, -1], [1, 0], [0, 1], [-1, 0]]

def next_coord_dir(x, y, dir, obs)
  dx, dy = $dirs[dir]
  coord = [x + dx, y + dy]

  while obs.include?(coord)
    dir = (dir + 1) % 4
    dx, dy = $dirs[dir]
    coord = [x + dx, y + dy]
  end

  coord + [dir]
end

def is_loop(obs_x, obs_y, x, y, obstacles, max_x, max_y)
  obstacles = obstacles.clone

  return false if obs_x == x && obs_y == y

  obstacles << [obs_x, obs_y]

  d = 0
  visited = Set[]
  while x.between?(0, max_x) && y.between?(0, max_y)
    visited << [x, y, d]

    x, y, d = next_coord_dir(x, y, d, obstacles)

    return true if visited.include?([x, y, d])
  end

  false
end

def solve(lines)
  max_y = lines.length - 1
  max_x = lines[0].length - 1

  obstacles = Set[]
  start_x = start_y = 0
  lines.each_with_index do |line, y|
    line.each_char.with_index do |char, x|
      obstacles << [x, y] if char == "#"
      start_x, start_y = x, y if char == "^"
    end
  end

  dir = 0
  visited = Set[]
  x, y = start_x, start_y
  new_obs = Set[]
  while x.between?(0, max_x) && y.between?(0, max_y)
    visited << [x, y, dir]

    new_obs << [x, y] if !new_obs.include?([x, y]) && is_loop(x, y, start_x, start_y, obstacles, max_x, max_y)

    x, y, dir = next_coord_dir(x, y, dir, obstacles)
  end

  new_obs.length
end
