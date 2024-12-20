require "set"

def solve(lines)
  grid = []
  start = nil
  endpos = nil
  lines.each_with_index do |line, y|
    grid << line.chars.map { |c| [c, 99999999999999, nil] }
    start = Complex(line.index("S"), y) if line.include?("S")
    endpos = Complex(line.index("E"), y) if line.include?("E")
  end
  grid[start.imag][start.real][1] = 0

  max_x = grid[0].length - 1
  max_y = grid.length - 1

  directions = [1 + 0i, 0 + 1i, -1 + 0i, 0 - 1i]

  queue = [[start, 0]]
  until queue.empty?
    coord, cost = queue.shift

    next if grid[coord.imag][coord.real] == "E"

    directions.each do |d|
      new_coord = coord + d
      new_cost = cost + 1

      cell = grid[new_coord.imag][new_coord.real]
      next if cell[0] == "#" || cell[1] <= new_cost

      cell[1] = new_cost
      cell[2] = coord

      queue.push([new_coord, new_cost])
    end
  end

  coord = endpos
  cheats = Set[]
  until coord.nil?
    new_cost = grid[coord.imag][coord.real][1] + 2

    directions.each do |d1|
      new_coord1 = coord + d1
      directions.each do |d2|
        new_coord2 = new_coord1 + d2

        next unless new_coord2.real.between?(0, max_x) && new_coord2.imag.between?(0, max_y) && grid[new_coord2.imag][new_coord2.real][0] != "#"

        saving = grid[new_coord2.imag][new_coord2.real][1] - new_cost
        cheats << [coord, new_coord2] if saving >= 100
      end
    end

    coord = grid[coord.imag][coord.real][2]
  end

  cheats.length
end
