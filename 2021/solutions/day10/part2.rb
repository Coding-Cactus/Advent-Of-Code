OPENERS = ["(", "[", "{", "<"]
CLOSERS = {"(" => ")", "[" => "]", "{" => "}", "<" => ">"}
SCORING = {")" => 1, "]" => 2, "}" => 3, ">" => 4}

scores = []
File.foreach("../../inputs/day10.txt") do |line|
	line = line.strip

	correct = true
	expected_chars = []

	line.split("").each do |chr|
		if OPENERS.include?(chr)
			expected_chars << CLOSERS[chr]
		elsif chr == expected_chars[-1]
			expected_chars = expected_chars[0...-1]
		else
			correct = false
		end

		break unless correct
	end

	next unless correct

	total = 0
	expected_chars.reverse.each do |chr|
		total *= 5
		total += SCORING[chr]
	end
	scores << total
end

puts scores.sort[scores.length / 2]
