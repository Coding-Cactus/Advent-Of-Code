grid = File.foreach("input.txt").map { |line| line.strip.chars }
max_x, max_y = grid[0].length - 1, grid.length - 1

step = 0
cycle_pos = 0
seen = {}
found_repetition = false
CYCLES = 4000000000
until step == CYCLES
  x = [0, 0, 0, max_y][cycle_pos]
  y = [0, 0, max_x, 0][cycle_pos]
  bottom_of_column = [[-1, -1, max_y + 1, max_x + 1][cycle_pos]] * [max_x + 1, max_y + 1][cycle_pos % 2]

  while x.between?(0, max_x) && y.between?(0, max_y)
    while x.between?(0, max_x) && y.between?(0, max_y)
      rock = grid[y][x]

      if rock == "#"
        case cycle_pos % 2
        when 0 then bottom_of_column[x] = y
        when 1 then bottom_of_column[y] = x
        end
      elsif rock == "O"
        grid[y][x] = "."
        case cycle_pos % 2
        when 0
          bottom_of_column[x] += cycle_pos == 0 ? 1 : -1
          grid[bottom_of_column[x]][x] = "O"
        when 1
          bottom_of_column[y] += cycle_pos == 1 ? 1 : -1
          grid[y][bottom_of_column[y]] = "O"
        end
      end

      case cycle_pos % 2
      when 0 then x += 1
      when 1 then y += 1
      end
    end

    case cycle_pos
    when 0 then x, y = 0, y + 1
    when 1 then x, y = x + 1, 0
    when 2 then x, y = 0, y - 1
    when 3 then x, y = x - 1, 0
    end
  end

  grid_str = grid.map { |r| r.join }.join(",")

  if !found_repetition && seen.include?(grid_str)
    found_repetition = true
    cycle_length = step - seen[grid_str]
    step += (CYCLES - step) / cycle_length * cycle_length
    cycle_pos = (cycle_pos + cycle_length) % 4
  end

  seen[grid_str] = step unless found_repetition || seen.include?(grid_str)
  step += 1
  cycle_pos = (cycle_pos + 1) % 4
end

total = grid.each_with_index.reduce(0) do |t, (row, y)|
  t + row.reduce(0) { |row_t, rock| row_t + (rock == "O" ? grid.length - y : 0) }
end

puts total
