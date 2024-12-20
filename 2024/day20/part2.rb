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
    base_cost = grid[coord.imag][coord.real][1]

    seen = Set[coord]
    queue = [coord]
    20.times do |n|
      new_queue = []
      queue.each do |c|
        directions.each do |d|
          new_coord = c + d
          new_cost = base_cost + n + 1

          next unless new_coord.real.between?(0, max_x) && new_coord.imag.between?(0, max_y) && !seen.include?(new_coord)

          if grid[new_coord.imag][new_coord.real][0] != "#"
            saving = grid[new_coord.imag][new_coord.real][1] - new_cost
            cheats << [coord, new_coord] if saving >= 100
          end

          seen << new_coord
          new_queue << new_coord
        end
        queue = new_queue
      end
    end

    coord = grid[coord.imag][coord.real][2]
  end

  cheats.length
end
