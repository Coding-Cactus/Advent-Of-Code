require "set"

def solve(lines)
  grid = []
  start_x = nil

  lines.each do |line|
    start_x = line.index(".") if start_x.nil?
    grid << line.chars
  end

  slopes     = %w[> v <]
  directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  max = 0
  tiles = [[start_x, 0, Set[[start_x, 0]]]]
  until tiles.empty?
    x, y, seen = tiles.pop

    directions.each_with_index do |(dx, dy), i|
      nx, ny = x + dx, y + dy
      n_coord = [nx, ny]

      next if seen.include?(n_coord) || !(nx.between?(0, grid[0].length - 1) && ny.between?(0, grid.length - 1))

      square = grid[ny][nx]
      next if square == "#" || (square != "." && square != slopes[i])

      if ny == grid.length - 1
        max = [max, seen.length].max
        break
      end

      tiles << [nx, ny, seen + [n_coord]]
    end
  end

  max
end
