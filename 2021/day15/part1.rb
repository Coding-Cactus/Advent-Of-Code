grid = []
File.foreach("input.txt") do |line|
	grid << []
	line.strip.split("").each { |num| grid[-1] << num.to_i }
end

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
