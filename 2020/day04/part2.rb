passports = [{}]
File.foreach("input.txt") do |line|
	if line == "\n"
		passports << {}
		next
	end

	line.strip.split(" ").map { |p| p.split(":") }.each { |field, value| passports[-1][field] = value }
end

EXPECTED = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

passports.select! do |passport|
	EXPECTED.all? { |field| passport.include?(field) }
end

count = passports.reduce(0) do |sum, passport|
	valid = true

	valid = false unless passport["byr"].to_i.between?(1920, 2002)
	valid = false unless passport["iyr"].to_i.between?(2010, 2020)
	valid = false unless passport["eyr"].to_i.between?(2020, 2030)
	valid = false unless passport["hcl"][0] == "#" && passport["hcl"].length == 7 && passport["hcl"][1..-1].to_i(16) <= "ffffff".to_i(16)
	valid = false unless ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(passport["ecl"])
	valid = false unless passport["pid"].length == 9

	if passport["hgt"][-2..-1] == "cm"
		valid = false unless passport["hgt"][0...-2].to_i.between?(150, 193)
	elsif passport["hgt"][-2..-1] == "in"
		valid = false unless passport["hgt"][0...-2].to_i.between?(59, 76)
	else
		valid = false
	end

	valid ? sum + 1 : sum
end

puts count
