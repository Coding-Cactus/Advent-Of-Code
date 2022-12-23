$grid = []
File.foreach("input.txt") { |line| $grid << line.strip.split("") }

def check_slope(dx, dy)
	x = y = trees = 0
	until y >= $grid.length
		trees += 1 if $grid[y][x] == "#"

		x = (x + dx) % $grid[y].length
		y += dy
	end
	trees
end

puts check_slope(1, 1) * check_slope(3, 1) * check_slope(5, 1) * check_slope(7, 1) * check_slope(1, 2)
