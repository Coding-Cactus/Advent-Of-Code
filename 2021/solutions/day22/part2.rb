def empty?(dimensions) = dimensions[0] == [0, 0] || dimensions[1] == [0, 0] || dimensions[2] == [0, 0]


class Box
	def initialize(dimensions)
		@dimensions = dimensions
		@boxes = []
	end

	def subtract(limits)
		cropped = crop(limits)

		return if empty?(cropped)

		@boxes.each { |inner_box| inner_box.subtract(cropped) }

		@boxes << Box.new(cropped)
	end

	def volume = @dimensions.reduce(1) { |total, (a, b)| total * (b-a) } - @boxes.reduce(0) { |sum, box| sum + box.volume }

	private

	def crop(limits)
		crop = limits.map { |l| l }

		crop.each_with_index do |(c0, c1), i|
			d0, d1 = @dimensions[i]

			c0 = [c0, d0].max
			c1 = [c1, d1].min
			crop[i] = c0 < c1 ? [c0, c1] : [0, 0]
		end

		crop
	end
end

boxes = []
File.foreach("../../inputs/day22.txt") do |line|
	state, cuboid = line.strip.split
	state = state == "on"

	x_range, y_range, z_range = cuboid.split(",")

	x1, x2 = x_range.split("=")[1].split("..").map(&:to_i)
	y1, y2 = y_range.split("=")[1].split("..").map(&:to_i)
	z1, z2 = z_range.split("=")[1].split("..").map(&:to_i)

	dimensions = [[x1, x2+1], [y1, y2+1], [z1, z2+1]]

	next if empty?(dimensions)

	boxes.each { |box| box.subtract(dimensions) }

	boxes << Box.new(dimensions) if state
end

puts boxes.reduce(0) { |sum, box| sum + box.volume }
