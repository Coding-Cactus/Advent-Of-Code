previous = nil
increasing_count = 0

File.foreach("input.txt") do |depth|
	depth = depth.to_i
	increasing_count += 1 if previous != nil && depth > previous
	previous = depth
end

puts increasing_count
