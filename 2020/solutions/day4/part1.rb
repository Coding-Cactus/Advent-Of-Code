passports = [[]]
File.foreach("../../inputs/day4.txt") do |line|
	if line == "\n"
		passports << []
		next
	end

	passports[-1] += line.strip.split(" ").map { |p| p.split(":")[0] }
end

EXPECTED = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

count = passports.reduce(0) do |sum, passport|
	EXPECTED.all? { |field| passport.include?(field) } ? sum + 1 : sum
end
puts count
