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

max = 0

# start from edge: left, top, right, bottom
(0..3).each do |edge|
  start_x = edge == 2 ? grid[0].length - 1 : 0
  start_y = edge == 3 ? grid.length - 1 : 0

  while start_x.between?(0, grid[0].length - 1) && start_y.between?(0, grid.length - 1)

    energised = Set[[start_x, start_y]]
    current   = [[start_x, start_y, edge]]    # [x, y, direction][]
    visited   = Set[[start_x, start_y, edge]]

    until current.empty?
      x, y, direction = current.pop
      next_moves[grid[y][x]][direction].each do |new_d|
        dx, dy = directions[new_d]
        _x, _y = x + dx, y + dy

        next unless _x.between?(0, grid[0].length - 1) && _y.between?(0, grid.length - 1)

        energised << [_x, _y]
        state = [_x, _y, new_d]
        unless visited.include?(state)
          current.unshift(state)
          visited << state
        end
      end
    end

    max = [max, energised.length].max

    start_y += 1 if edge % 2 == 0
    start_x += 1 if edge % 2 == 1
  end
end

puts max
