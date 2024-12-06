def solve(lines)
  grid = lines.map(&:chars)

  count = 0
  grid.each_with_index do |row, y|
    row.each_with_index do |char, x|
      next if y == 0 || x == 0 || y == grid.length - 1 || x == row.length - 1

      if char == "A"
        a = grid[y-1][x-1] + "A" + grid[y+1][x+1]
        b = grid[y+1][x-1] + "A" + grid[y-1][x+1]
        count += 1 if [a, b].all? { |c| c == "MAS" || c == "SAM" }
      end
    end
  end

  count
end
