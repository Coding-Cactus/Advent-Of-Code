def solve(lines)
  grid = lines.map(&:chars)
  count = 0
  loop do
    freeable = grid.each_with_index.map do |row, y|
      row.each_with_index.reduce([]) do |c, (cell, x)|
        c + (cell == '@' && [0 - 1i, 1 - 1i, 1 + 0i, 1 + 1i, 0 + 1i, -1 + 1i, -1 + 0i, -1 - 1i].reduce(0) do |acc, d|
          nx, ny = x + d.real, y + d.imag
          acc + (nx.between?(0, row.length-1) && ny.between?(0, grid.length-1) && grid[ny][nx] == '@' ? 1 : 0)
        end < 4 ? [Complex(x, y)] : [])
      end
    end.flatten
    return count if freeable.empty?
    count += freeable.length
    freeable.each { |c| grid[c.imag][c.real] = "." }
  end
end
