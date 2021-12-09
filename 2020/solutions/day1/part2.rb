base_numbers = []
combined_numbers = []
File.foreach("../../inputs/day1.txt") do |file_num|
	file_num = file_num.strip.to_i

	found = false
	combined_numbers.each do |array_num|
		num1, num2 = array_num
		if num1 + num2 + file_num == 2020
			puts num1 * num2 * file_num
			found = true
			break
		end
	end

	break if found

	base_numbers.each { |num| combined_numbers << [num, file_num] }
	base_numbers << file_num
end
