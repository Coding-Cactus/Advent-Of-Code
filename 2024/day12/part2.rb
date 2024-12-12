require "set"

def sides(region, grid)
  dirs = [0 - 1i, 1 + 0i, 0 + 1i, -1 + 0i]
  diags = [1 - 1i, 1 + 1i, -1 + 1i, -1 - 1i]

  sides = 0
  region.each do |c|
    neighbours = dirs.count { |d| region.include?(c + d) }

    if neighbours == 0
      sides += 4
    elsif neighbours == 1
      sides += 2
    else
      type = grid[c.imag][c.real]
      diags.each do |d|
        dc = c + d
        dtype = grid[dc.imag][dc.real]
        adjtype1 = grid[dc.imag][c.real]
        adjtype2 = grid[c.imag][dc.real]

        if dtype != type
          sides += 1 if (adjtype1 == type && adjtype2 == type) || (adjtype1 != type && adjtype2 != type)
        else
          sides += 1 if (adjtype1 != type && adjtype2 != type)
        end
      end
    end
  end

  sides
end

def solve(lines)
  dirs = [0 - 1i, 1 + 0i, 0 + 1i, -1 + 0i]

  lines.map! { |line| "." + line + "." }
  lines = ["." * lines.first.length] + lines + ["." * lines.first.length]

  grid = lines.map(&:chars)
  max_y = grid.length - 1
  max_x = grid.first.length - 1

  seen = Set[]
  regions = []
  grid.each_with_index do |row, y|
    row.each_with_index do |char, x|
      next if char == "."

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

          next unless nx.between?(0, max_x) && ny.between?(0, max_y) && !region.include?(nc)

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
    total + region.length * sides(region, grid)
  end
end
