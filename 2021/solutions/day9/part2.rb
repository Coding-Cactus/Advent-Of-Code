map = []
File.foreach("../../inputs/day9.txt") { |line| map << line.strip.split("").map { |n| n.to_i } }

basin_sizes = []
map.each_with_index do |row, y|
	row.each_with_index do |num, x|
		next if num == 9 || map[y][x] == -1

		basin_count = 0

		points = [[x, y]]
		until points.length == 0
			new_points = []
			points.each do |point|
				next if map[point[1]][point[0]] == -1
				map[point[1]][point[0]] = -1
				basin_count += 1

				new_x, new_y = point[0] - 1, point[1]
				unless new_x < 0
					new_map_point = map[new_y][new_x]
					new_points << [new_x, new_y] unless new_map_point == 9 || new_map_point == -1 || new_points.include?([new_x, new_y])
				end

				new_x, new_y = point[0] + 1, point[1]
				unless new_x > row.length - 1
					new_map_point = map[new_y][new_x]
					new_points << [new_x, new_y] unless new_map_point == 9 || new_map_point == -1 || new_points.include?([new_x, new_y])
				end

				new_x, new_y = point[0], point[1] - 1
				unless new_y < 0
					new_map_point = map[new_y][new_x]
					new_points << [new_x, new_y] unless new_map_point == 9 || new_map_point == -1 || new_points.include?([new_x, new_y])
				end

				new_x, new_y = point[0], point[1] + 1
				unless new_y > map.length - 1
					new_map_point = map[new_y][new_x]
					new_points << [new_x, new_y] unless new_map_point == 9 || new_map_point == -1 || new_points.include?([new_x, new_y])
				end
			end
			points = []
			new_points.each { |p| points << p }
		end

		basin_sizes << basin_count
	end
end

puts basin_sizes.sort.reverse[0...3].reduce { |total, num| total * num }
