correct = 0
File.foreach("../../inputs/day2.txt") do |line|
	indicies, letter, password = line.strip.split

	index1, index2 = indicies.split("-").map { |n| n.to_i - 1 }
	letter = letter[0]

	correct += 1 if (password[index1] == letter && password[index2] != letter) || (password[index1] != letter && password[index2] == letter)
end

puts correct
