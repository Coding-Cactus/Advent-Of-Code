notes = []
File.open("input.txt") do |file|
	file.read.split("\n").each do |line|
		notes << [line.split(" | ")[0].split(" "), line.split(" | ")[1].split(" ")]
	end
end


DIGITS = {
	"abcefg" => 0,
	"cf" => 1,
	"acdeg" => 2,
	"acdfg" => 3,
	"bcdf" => 4,
	"abdfg" => 5,
	"abdefg" => 6,
	"acf" => 7,
	"abcdefg" => 8,
	"abcdfg" => 9
}


def translate(digit, translation) = digit.split("").map { |d| translation[d] }.sort.join


count = 0
notes.each do |note|
	signal, output = note

	known = {}
	(signal + output).each do |digit|
		case digit.length
		when 2
			known[digit] = 1
		when 3
			known[digit] = 7
		when 4
			known[digit] = 4
		when 7
			known[digit] = 8
		end
		break if known.length == 4
	end

	["a", "b", "c", "d", "e", "f", "g"].permutation.each do |perm|
		translation = {}
		perm.each_with_index { |p, index| translation[p] = "abcdefg"[index] }

		next unless known.all? { |digit, num| DIGITS[translate(digit, translation)] == num }

		next unless signal.all? { |digit| DIGITS.include?(translate(digit, translation)) }

		count += output.reduce("") { |num, digit| num + DIGITS[ translate(digit, translation)].to_s }.to_i
		break
	end
end

puts count
