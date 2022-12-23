count = 0
group = []
File.foreach("input.txt") do |line|
	if line == "\n"
		count += group.length
		group = []
	else
		line.strip.split("").each { |question| group << question unless group.include?(question) }
	end
end
count += group.length

puts count
