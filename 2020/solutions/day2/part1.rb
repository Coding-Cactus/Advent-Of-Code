correct = 0
File.foreach("../../inputs/day2.txt") do |line|
	limits, letter, password = line.strip.split

	limits = limits.split("-").map { |n| n.to_i }
	letter = letter[0]

	correct += 1 if password.split("").reduce(0) { |count, char| char == letter ? count + 1 : count }.between?(*limits)
end

puts correct
