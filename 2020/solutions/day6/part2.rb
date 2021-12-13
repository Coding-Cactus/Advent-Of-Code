count = 0
group = Hash.new(0)
group_size = 0

File.foreach("../../inputs/day6.txt") do |line|
	if line == "\n"
		count += group.select { |_, num| num == group_size }.length
		group = Hash.new(0)
		group_size = 0
	else
		group_size += 1
		line.strip.split("").each { |question| group[question] += 1 }
	end
end
	count += group.select { |_, num| num == group_size }.length

puts count
