points_covered = Hash.new(0)

File.foreach("../../inputs/day5.txt") do |line|
	start_coord, end_coord = line.split(" -> ")
	start_x, start_y = start_coord.split(",").map { |n| n.to_i }
	end_x, end_y = end_coord.split(",").map { |n| n.to_i }

	next if start_x != end_x && start_y != end_y

	current_x, current_y = start_x, start_y
	direction_x = current_x < end_x ? 1 : -1
	direction_y = current_y < end_y ? 1 : -1

	points_covered["#{current_x},#{current_y}"] += 1
	until current_x == end_x && current_y == end_y
		current_x += direction_x if current_x != end_x
		current_y += direction_y if current_y != end_y

		points_covered["#{current_x},#{current_y}"] += 1
	end
end

puts points_covered.reduce(0) { |sum, (_, num)| num >= 2 ? sum + 1 : sum }
