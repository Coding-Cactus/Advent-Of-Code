bin = ""
File.open("input.txt") do |file|
	hex = file.read.strip
	bin = hex.split("").map do |h|
		b = h.to_i(16).to_s(2)
		"0"*(4-b.length) + b
	end.join
end


def parse(bin)
	version = bin[0...3].to_i(2)
	id = bin[3...6].to_i(2)
	version_count = version

	bin = bin[6..-1]

	if id == 4
		loop do
			bits = bin[0...5]
			bin = bin[5..-1]
			break if bits[0] == "0"
		end
		return version_count, bin
	end

	length_type = bin[0]
	bin = bin[1..-1]

	if length_type == "0"
		length = bin[0...15].to_i(2)
		bin = bin[15..-1]

		size = bin.length
		while size - bin.length < length
			count, bin = parse(bin)
			version_count += count
		end
	else
		length = bin[0...11].to_i(2)
		bin = bin[11..-1]

		length.times do
			count, bin = parse(bin)
			version_count += count
		end
	end
	[version_count, bin]
end

puts parse(bin)[0]
