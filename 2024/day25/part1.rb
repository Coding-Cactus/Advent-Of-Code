def solve(lines)
  grids = lines.join("\n").split("\n\n").map { |grid| grid.split("\n").map(&:chars) }

  keys = []
  locks = []
  grids.each do |grid|
    levels = grid.transpose.map { |col| col.count("#") }
    if grid[0].include?("#")
      locks << levels
    else
      keys << levels
    end
  end

  count = 0
  keys.each do |key|
    locks.each do |lock|
      count += 1 if key.each_with_index.all? { |k, i| k + lock[i] <= 7 }
    end
  end
  count
end
