require "set"

def solve(lines)
  start_x = start_y = nil

  grid = []
  lines.each_with_index do |line, y|
    grid << line.chars
    start_x, start_y = y, line.index("S") if line.include?("S")
  end

  grid[start_y][start_x] = "."

  grids     = (26501365.0 / grid.length).ceil
  remainder = 26501365 % grid.length

  s = []
  sequence_points = (0...3).map { |n| remainder + n * grid.length - 1 }

  diffs = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  gardens = [[start_x, start_y]]
  (remainder + 2 * grid.length).times do |n|
    new_gardens = Set[]
    gardens.each do |x, y|
      diffs.each do |dx, dy|
        nx, ny = x + dx, y + dy
        new_gardens << [nx, ny] if grid[ny % grid.length][nx % grid.length] == "."
      end
    end
    gardens = new_gardens

    s << gardens.length if sequence_points.include?(n)
  end

  # calculate nth term coefficients
  a = (s[2] - s[1] - (s[1] - s[0])) / 2
  b = s[1] - s[0] - 3 * a
  c = s[0] - b - a

  a * grids**2 + b * grids + c
end
