crabs = Hash.new(0)
File.open("input.txt") { |file| file.read.strip.split(",").map { |n| n.to_i }.each { |pos| crabs[pos] += 1 } }

def fuel(end_pos, crabs)
	crabs.reduce(0) do |sum, (pos, count)|
		d = (end_pos - pos).abs
		sum + d * (d+1) / 2 * count
	end
end

left = crabs.reduce(99999) { |min, (pos, _)| pos < min ? pos : min }
right = crabs.reduce(0) { |max, (pos, _)| pos > max ? pos : max } + 1


while right - left > 2
	left_mid = left + (right - left) / 3
	right_mid = right - (right - left) / 3

	fuel(left_mid, crabs) < fuel(right_mid, crabs) ? right = right_mid : left = left_mid
end

fuel_costs = []
left.upto(right+1) { |end_pos| fuel_costs << fuel(end_pos, crabs) }
puts fuel_costs.reduce { |min, cost| cost < min ? cost : min }
