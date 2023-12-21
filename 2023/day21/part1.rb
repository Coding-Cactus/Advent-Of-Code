require "set"

def solve(lines)
  start_x = start_y = nil

  grid = []
  lines.each_with_index do |line, y|
    grid << line.chars
    start_x, start_y = y, line.index("S") if line.include?("S")
  end

  grid[start_y][start_x] = "."

  gardens = [[start_x, start_y]]
  diffs = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  64.times do
    new_gardens = Set[]
    gardens.each do |x, y|
      diffs.each do |dx, dy|
        nx, ny = x + dx, y + dy
        new_gardens << [nx, ny] if nx.between?(0, grid[0].length - 1) && ny.between?(0, grid.length - 1) && grid[ny][nx] == "."
      end
    end
    gardens = new_gardens
  end

  gardens.length
end
