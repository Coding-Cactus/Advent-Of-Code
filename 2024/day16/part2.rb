require "set"

def solve(lines)
  grid = []
  start = nil
  endpos = nil
  lines.each_with_index do |line, y|
    grid << line.chars.map { |c| [c, Array.new(4) { 99999999999999 }, Array.new(4) { [] }] }
    start = Complex(line.index("S"), y) if line.include?("S")
    endpos = Complex(line.index("E"), y) if line.include?("E")
  end
  grid[start.imag][start.real][1] = [0, 1000, 2000, 1000]

  directions = [1 + 0i, 0 + 1i, -1 + 0i, 0 - 1i]
  turns = [0, 1, 2, -1]

  queue = [[start, 0, 0]]
  until queue.empty?
    coord, dir_i, cost = queue.shift

    turns.each do |delta_i|
      i = (dir_i + delta_i) % 4
      dir = directions[i]
      new_coord = coord + dir
      new_cost = cost + 1000*delta_i.abs + 1

      cell = grid[new_coord.imag][new_coord.real]
      prev_cost = cell[1].min

      next if cell[0] == "#"

      turns.each do |di|
        _i = (i + di) % 4
        cst = new_cost + 1000*di.abs

        if cst < cell[1][_i]
          cell[1][_i] = cst
          cell[2][_i] = [coord]
        elsif cst == cell[1][_i]
          cell[2][_i] << coord
        end
      end

      queue.push([new_coord, i, new_cost]) if new_cost < prev_cost
    end
  end

  min_cost = grid[endpos.imag][endpos.real][1].min

  stack = []
  grid[endpos.imag][endpos.real][1].each_with_index { |c, i| stack << [endpos, i] if c == min_cost }

  seats = Set[]
  until stack.empty?
    coord, prev_dir_i = stack.pop

    seats << coord

    grid[coord.imag][coord.real][2][prev_dir_i].each { |c| stack << [c, directions.index(coord - c)] }
  end
  seats.length
end
