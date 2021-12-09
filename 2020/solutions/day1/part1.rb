numbers = []
File.foreach("../../inputs/day1.txt") do |file_num|
	file_num = file_num.strip.to_i

	found = false
	numbers.each do |array_num|
		if array_num + file_num == 2020
			puts array_num * file_num
			found = true
			break
		end
	end
	
	break if found

	numbers << file_num
end
