require "set"

def solve(lines)
  dirs = [0 - 1i, 1 + 0i, 0 + 1i, -1 + 0i]

  grid = lines.map(&:chars)
  size = grid.length - 1

  seen = Set[]
  regions = []
  grid.each_with_index do |row, y|
    row.each_with_index do |char, x|
      coord = Complex(x, y)

      next if seen.include?(coord)

      seen << coord
      region = Set[coord]
      stack = [coord]
      until stack.empty?
        c = stack.pop

        dirs.each do |dir|
          nc = c + dir
          nx, ny = nc.real, nc.imag

          next unless nx.between?(0, size) && ny.between?(0, size) && !region.include?(nc)

          if grid[ny][nx] == char
            region << nc
            stack << nc
            seen << nc
          end
        end
      end

      regions << region
    end
  end

  regions.reduce(0) do |total, region|
    total + region.length * region.map { |c| dirs.reject { |d| region.include?(c + d) }.length }.sum
  end
end
