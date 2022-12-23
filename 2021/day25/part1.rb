grid = []
File.foreach("input.txt") { |line| grid << line.strip.split("") }


steps = 0

loop do
	old_grid = grid.map(&:clone)
	new_grid = Array.new(grid.length) { Array.new(grid[0].length) { "." } }

	downs = []
	grid.each_with_index do |row, y|
		row.each_with_index do |cucumber, x|
			next if cucumber == "."

			if cucumber == "v"
				downs << [x, y]
				new_grid[y][x] = cucumber
				next
			end

			next_index = (x+1) % row.length
			if row[next_index] == "."
				new_grid[y][next_index] = cucumber
			else
				new_grid[y][x] = cucumber
			end
		end
	end

	grid = new_grid.map(&:clone)

	downs.each do |x, y|
		next_index = (y+1) % grid.length
		if grid[next_index][x] == "."
			new_grid[next_index][x] = "v"
			new_grid[y][x] = "."
		end
	end

	steps += 1
	grid = new_grid.map(&:clone)

	break if old_grid == new_grid
end
puts steps
