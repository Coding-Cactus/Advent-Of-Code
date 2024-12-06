def xmas(row) = row[..-4].each_index.select { |i| row[i...(i+4)].join == "XMAS" }.length

def solve(lines)
  grid = lines.map(&:chars)

  count = 0
  2.times do
    grid.each do |row|
      count += xmas(row)
      count += xmas(row.reverse)
    end

    grid.each_index do |y|
      upper_diagonal = []
      lower_diagonal = []
      (grid.length - y).times do |x|
        upper_diagonal << grid[x][x + y]
        lower_diagonal << grid[y + x][x]
      end
      upper_diagonal = [] if y == 0 # remove duplicate main diagonal

      count +=
        xmas(lower_diagonal) +
        xmas(lower_diagonal.reverse) +
        xmas(upper_diagonal) +
        xmas(upper_diagonal.reverse)
    end

    grid = grid.transpose.map(&:reverse)
  end

  count
end
