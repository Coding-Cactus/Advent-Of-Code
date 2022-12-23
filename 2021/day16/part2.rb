bin = ""
File.open("input.txt") do |file|
	hex = file.read.strip
	bin = hex.split("").map do |h|
		b = h.to_i(16).to_s(2)
		"0"*(4-b.length) + b
	end.join
end


class Packet
	def initialize(version, id, value, sub_packets)
		@id          = id
		@value       = value
		@version     = version
		@sub_packets = sub_packets
	end

	def eval
		case @id
		when 0
			@sub_packets.reduce(0) { |sum, packet| sum + packet.eval }
		when 1
			@sub_packets.reduce(1) { |product, packet| product * packet.eval }
		when 2
			@sub_packets.reduce(999999999999) { |min, packet| packet.eval < min ? packet.eval : min }
		when 3
			@sub_packets.reduce(0) { |max, packet| packet.eval > max ? packet.eval : max }
		when 4
			@value
		when 5
			@sub_packets[0].eval > @sub_packets[1].eval ? 1 : 0
		when 6
			@sub_packets[0].eval < @sub_packets[1].eval ? 1 : 0
		when 7
			@sub_packets[0].eval == @sub_packets[1].eval ? 1 : 0
		end
	end
end


def parse(bin)
	version = bin[0...3].to_i(2)
	id = bin[3...6].to_i(2)

	bin = bin[6..-1]

	if id == 4
		num = ""
		loop do
			bits = bin[0...5]
			num += bits[1..5]
			bin = bin[5..-1]
			break if bits[0] == "0"
		end
		return Packet.new(version, id, num.to_i(2), []), bin
	end

	length_type = bin[0]
	bin = bin[1..-1]
	packets = []

	if length_type == "0"
		length = bin[0...15].to_i(2)
		bin = bin[15..-1]

		size = bin.length
		while size - bin.length < length
			packet, bin = parse(bin)
			packets << packet
		end
	else
		length = bin[0...11].to_i(2)
		bin = bin[11..-1]

		length.times do
			packet, bin = parse(bin)
			packets << packet
		end
	end
	[Packet.new(version, id, 0, packets), bin]
end

puts parse(bin)[0].eval
