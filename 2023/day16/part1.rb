require "set"

grid = File.foreach("input.txt").reduce([]) { |g, line| g + [line.strip.chars] }

# [right, down, left, up]
directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]

# current_square => current_direction => new_directions
next_moves = {
  "."  => [[0], [1], [2], [3]],
  "/"  => [[3], [2], [1], [0]],
  "\\" => [[1], [0], [3], [2]],
  "-"  => [[0], [0, 2], [2], [0, 2]],
  "|"  => [[1, 3], [1], [1, 3], [3]]
}

start_coord, start_direction = [0, 0], 0

energised = Set[start_coord]
visited = Set[[start_coord, start_direction]]
current = Set[[start_coord, start_direction]]

until current.empty?
  next_cur = Set[]

  current.each do |(x, y), direction|
    next_moves[grid[y][x]][direction].each do |new_d|
      dx, dy = directions[new_d]
      _x, _y = x + dx, y + dy

      next unless _x.between?(0, grid[0].length - 1) && _y.between?(0, grid.length - 1)

      energised << [_x, _y]
      next_cur  << [[_x, _y], new_d] unless visited.include?([[_x, _y], new_d])
      visited   << [[_x, _y], new_d]
    end
  end

  current = next_cur
end

puts energised.length
