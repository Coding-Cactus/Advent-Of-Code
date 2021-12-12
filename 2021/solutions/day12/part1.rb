connections = Hash.new([])

File.foreach("../../inputs/day12.txt") do |line|
	cave1, cave2 = line.strip.split("-")
	connections[cave1] += [cave2]
	connections[cave2] += [cave1]
end


total = 0
current_paths = [["start"]]

until current_paths.length == 0
	next_paths = []
	current_paths.each do |current_path|
		cave = current_path[-1]
		connections[cave].each do |next_cave|
			if next_cave == "end"
				total += 1
			elsif next_cave.downcase != next_cave || current_path.none? { |c| c.downcase == c && c == next_cave }
				next_paths << current_path + [next_cave]
			end
		end
	end
	current_paths = next_paths.map { |c| c }
end

puts total
