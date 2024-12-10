require 'set'

def solve(lines)
  dirs = [0 - 1i, 1 + 0i, 0 + 1i, -1 + 0i]

  grid = []
  lines.each { |line| grid << line.chars.map(&:to_i) }

  max = grid[0].length - 1

  sum = 0
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      next unless cell.zero?

      coord = Complex(x, y)

      ends = Set[]
      stack = [coord]
      until stack.empty?
        c = stack.pop
        num = grid[c.imag][c.real]

        dirs.each do |dir|
          new_c = c + dir

          nx, ny = new_c.real, new_c.imag
          next unless nx.between?(0, max) && ny.between?(0, max)

          n = grid[ny][nx]

          next if n != num + 1

          ends << new_c if n == 9
          stack << new_c if n < 9
        end
      end

      sum += ends.length
    end
  end

  sum
end
