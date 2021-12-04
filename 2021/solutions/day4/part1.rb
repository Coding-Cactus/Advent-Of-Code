numbers = []
boards  = []

File.open("../../inputs/day4.txt") do |file|
	file = file.read.split("\n")
	numbers = file[0].split(",").map { |n| n.to_i }

	file[1...file.length].each do |line|
		if line == ""
			boards << []
			next
		end

		boards[-1] << line.split(" ").reject { |n| n == "" }.map { |n| n.to_i }
	end
end


won = false
used_numbers = []
unmarked_count = 0

numbers.each do |num|
	used_numbers << num

	boards.each do |board|
		unmarked_count = 0

		board.each do |row|
			row.each { |n| unmarked_count += n unless used_numbers.include?(n) }
			won = true if row.all? { |n| used_numbers.include?(n) }

			row.each_with_index do |_, col|
				column = []
				board.each { |r| column << r[col] }

				won = true if column.all? { |n| used_numbers.include?(n) }
			end

		end

		break if won
	end
	break if won
end

puts unmarked_count * used_numbers[-1]
