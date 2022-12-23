count = 0

map = []
File.foreach("input.txt") { |line| map << line.strip.split("").map { |n| n.to_i } }

map.each_with_index do |row, y|
	row.each_with_index do |num, x|
		next if num == 9

		smallest = true

		smallest = num < map[y-1][x] if y > 0
		next unless smallest

		smallest = num < map[y+1][x] if y < map.length - 1
		next unless smallest

		smallest = num < map[y][x-1] if x > 0
		next unless smallest

		smallest = num < map[y][x+1] if x < row.length - 1
		next unless smallest
		count += num + 1
	end
end

puts count
