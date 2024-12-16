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
    coord, dir, cost = queue.shift

    return cost if grid[coord.imag][coord.real] == "E"

    turns.each  do |di|
      i = (dir + di) % 4
      d = directions[i]
      new_coord = coord + d
      new_cost = cost + 1000*di.abs + 1

      cell = grid[new_coord.imag][new_coord.real]
      next if cell[0] == "#"
      prev_cost = cell[1].min

      turns.each do |ddi|
        ii = (i + ddi) % 4
        cst = new_cost + 1000*ddi.abs

        if cst < cell[1][ii]
          cell[1][ii] = cst
          cell[2][ii] = [coord]
        elsif cst == cell[1][ii]
          cell[2][ii] << coord
        end
      end

      queue.push([new_coord, i, new_cost]) if new_cost < prev_cost
    end
  end

  min_cost = grid[endpos.imag][endpos.real][1].min

  seats = Set[]
  stack = grid[endpos.imag][endpos.real][1].each_with_index.select { |cost, i| cost == min_cost }.map { |_, i| [endpos, i] }
  until stack.empty?
    coord, prev_dir = stack.pop

    seats << coord

    grid[coord.imag][coord.real][2][prev_dir].each { |c| stack << [c, directions.index(coord - c)] }
  end
  seats.length
end
