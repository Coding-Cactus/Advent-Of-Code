connections = Hash.new([])

File.foreach("input.txt") do |line|
	cave1, cave2 = line.strip.split("-")
	connections[cave1] += [cave2]
	connections[cave2] += [cave1]
end


total = 0
current_paths = [[false, "start"]]

until current_paths.length == 0
	next_paths = []
	current_paths.each do |current_path|
		cave = current_path[-1]

		connections[cave].each do |next_cave|
			visited_cave = next_cave.downcase == next_cave ? current_path[2..-1].any? { |c| c == next_cave } : false

			if next_cave == "end"
				total += 1
			elsif next_cave != "start" && (!visited_cave || !current_path[0])
				next_paths << [visited_cave || current_path[0]] + current_path[1..-1] + [next_cave]
			end
		end
	end
	current_paths = next_paths.map { |c| c }
end

puts total
