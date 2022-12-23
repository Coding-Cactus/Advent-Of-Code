grid = []
File.foreach("input.txt") do |line|
	grid << line.strip.split("").map { |num| num.to_i }

	1.upto(4) do |n|
		grid[-1] += line.strip.split("").map { |num| (num.to_i + n) % 9 == 0 ? 9 : (num.to_i + n) % 9 }
	end
end

new_grid = grid.map { |r| r }
1.upto(4) do |n|
	grid.each do |row|
		new_grid << row.map { |num| (num.to_i + n) % 9 == 0 ? 9 : (num.to_i + n) % 9 }
	end
end
grid = new_grid.map { |r| r }


best = []
grid.each_index do |i|
	best << grid[i].map { 9999999999 }
end

queue = [[0, 0, 0]]

until queue.length == 0
	queue = queue.sort_by { |d| d[0] }
	distance, x, y = queue.shift

	[[x+1, y], [x, y+1], [x-1, y], [x, y-1]].each do |next_x, next_y|
		if 0 <= next_x && next_x < grid[0].length && 0 <= next_y && next_y < grid.length

			next_distance = distance + grid[next_y][next_x]
			if best[next_y][next_x] > next_distance
				best[next_y][next_x] = next_distance
				queue << [next_distance, next_x, next_y]
			end
		end
	end
end

puts best[-1][-1]
