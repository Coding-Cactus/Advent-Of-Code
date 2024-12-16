def solve(lines)
  grid = []
  start = nil
  endpos = nil
  lines.each_with_index do |line, y|
    grid << line.chars.map { |c| [c, 99999999999999] }
    start = Complex(line.index("S"), y) if line.include?("S")
    endpos = Complex(line.index("E"), y) if line.include?("E")
  end

  directions = [1 + 0i, 0 + 1i, -1 + 0i, 0 - 1i]
  turns = [0, 1, 2, -1]

  queue = [[start, 0, 0]]
  until queue.empty?
    coord, dir, cost = queue.shift

    return cost if grid[coord.imag][coord.real] == "E"

    turns.each do |di|
      i = (dir + di) % 4
      d = directions[i]
      new_coord = coord + d
      new_cost = cost + 1000*di.abs + 1

      cell = grid[new_coord.imag][new_coord.real]
      next if cell[0] == "#" || cell[1] <= new_cost

      cell[1] = new_cost

      queue.push([new_coord, i, new_cost])
    end
  end

  grid[endpos.imag][endpos.real][1]
end
