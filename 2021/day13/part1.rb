coords = []
width  = 0
height = 0
folds  = []
at_folds = false

File.foreach("input.txt") do |line|
	if line == "\n"
		at_folds = true
		next
	end

	if at_folds
		folds << line.strip.split[-1].split("=")
	else
		x, y = line.strip.split(",").map { |c| c.to_i }
		coords << [x, y]

		width = x+1  if x+1 > width
		height = y+1 if y+1 > height
	end
end

grid = Array.new(height) { Array.new(width) { "." } }

coords.each { |x, y| grid[y][x] = "#" }

fold_direction = folds[0][0]
fold_line = folds[0][1].to_i

if fold_direction == "x"
	new_grid = []
	grid.each do |row|
		new_row = []

		row[0...fold_line].each { |point| new_row << point }

		new_grid << new_row
	end

	grid.each_with_index do |row, y|
		row[fold_line..-1].each_with_index do |point, x|
			if point == "#"
				new_grid[y][fold_line-x] = grid[y][fold_line+x]
			end
		end
	end
else
	new_grid = grid[0...fold_line]

	grid[fold_line..-1].each_with_index do |row, y|
		row.each_with_index do |point, x|
			if point == "#"
				new_grid[fold_line-y][x] = grid[fold_line+y][x]
			end
		end
	end
end
grid = new_grid.map { |r| r }

count = grid.reduce(0) do |sum, row|
	sum + row.reduce(0) { |sum2, point| point == "#" ? sum2 + 1 : sum2 }
end

puts count
