enhancement = nil
grid = []
File.foreach("input.txt") do |line|
	if enhancement == nil
		enhancement = line.strip.gsub(".", "0").gsub("#", "1")
	elsif line != "\n"
		grid << line.strip.gsub(".", "0").gsub("#", "1").split("")
	end
end

grid.map! { |r| ["0"] + r + ["0"] }
grid = [Array.new(grid[0].length) { "0" }] + grid + [Array.new(grid[0].length) { "0" }] # add padding


50.times do
	grid.map! { |r| [grid[0][0]] + r + [grid[0][0]] }
	grid = [Array.new(grid[0].length) { grid[0][0]}] + grid + [Array.new(grid[0].length) { grid[0][0]}] # add padding
	new_grid = Array.new(grid.length) { Array.new(grid[0].length) { "0" } }

	grid.each_with_index do |row, y|
		row.each_with_index do |pixel, x|

			index = (
				# top
				(y == 0 || x == 0 ? pixel : grid[y-1][x-1]) +
				(y == 0 ? pixel : grid[y-1][x]) +
				(y == 0 || x == row.length-1 ? pixel : grid[y-1][x+1]) +

				# middle
				(x == 0 ? pixel : grid[y][x-1]) +
				pixel +
				(x == row.length-1 ? pixel : grid[y][x+1]) +

				#bottom
				(y == grid.length-1 || x == 0 ? pixel : grid[y+1][x-1]) +
				(y == grid.length-1 ? pixel : grid[y+1][x]) +
				(y == grid.length-1 || x == row.length-1 ? pixel : grid[y+1][x+1])
			).to_i(2)

			new_pixel = enhancement[index]

			new_grid[y][x] = new_pixel
		end
	end
	grid = new_grid.map { |r| r }
end

puts grid.reduce(0) { |sum, row| sum + row.reduce(0) { |rsum, pixel| pixel == "1" ? rsum + 1 : rsum } }
