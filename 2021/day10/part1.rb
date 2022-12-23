OPENERS = ["(", "[", "{", "<"]
CLOSERS = {"(" => ")", "[" => "]", "{" => "}", "<" => ">"}
SCORING = {")" => 3, "]" => 57, "}" => 1197, ">" => 25137}

count = 0
File.foreach("input.txt") do |line|
	line = line.strip

	wrong_char = ""
	correct = true
	expected_chars = []

	line.split("").each do |chr|
		if OPENERS.include?(chr)
			expected_chars << CLOSERS[chr]
		elsif chr == expected_chars[-1]
			expected_chars = expected_chars[0...-1]
		else
			wrong_char = chr
			correct = false
		end

		unless correct
			count += SCORING[wrong_char]
			break
		end
	end
end

puts count
