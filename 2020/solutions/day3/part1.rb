grid = []
File.foreach("../../inputs/day3.txt") { |line| grid << line.strip.split("") }

x = y = trees = 0
until y == grid.length
	trees += 1 if grid[y][x] == "#"

	x = (x + 3) % grid[y].length
	y += 1
end

puts trees
