require "fc"
require "set"

grid = File.foreach("input.txt").map { |line| line.strip.chars.map(&:to_i) }

seen = Set[]
paths = FastContainers::PriorityQueue.new(:min) # [x, y, direction, heat_loss][]
paths.push([0, 0, nil, 0], 0)

until paths.empty?
  x, y, direction, heat_loss = paths.pop

  if x == grid[0].length - 1 && y == grid.length - 1
    puts heat_loss
    break
  end

  state = [x, y, direction]
  next if seen.include?(state)
  seen << state

  (0..3).each do |new_d|
    next if !direction.nil? && new_d % 2 == direction % 2

    nx, ny, n_heat = x, y, heat_loss

    3.times do
      nx += [1, 0, -1, 0][new_d]
      ny += [0, 1, 0, -1][new_d]

      break unless nx.between?(0, grid[0].length - 1) && ny.between?(0, grid.length - 1)

      n_heat += grid[ny][nx]
      paths.push([nx, ny, new_d, n_heat], n_heat)
    end
  end
end
