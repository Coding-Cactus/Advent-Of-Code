notes = []
File.open("../../inputs/day8.txt") do |file|
	file.read.split("\n").each do |line|
		notes << line.split(" | ")[1].split(" ")
	end
end

count = 0

notes.map do |note|
	note.each do |num|
		count += 1 if [2, 3, 4, 7].include?(num.length)
	end
end

puts count
