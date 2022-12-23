depth_groups = []

File.foreach("input.txt") do |depth|
	depth = depth.to_i
	depth_groups[-2] << depth if depth_groups.length > 1
	depth_groups[-1] << depth if depth_groups.length > 0
	depth_groups << [depth]
end

previous = nil
increasing_count = 0

depth_groups.each do |group|
	depth_sum = group.reduce { |sum, num| num + sum }

	increasing_count += 1 if previous != nil && depth_sum > previous
	previous = depth_sum
end

puts increasing_count
