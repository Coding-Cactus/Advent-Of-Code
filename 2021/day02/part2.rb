horizontal = depth = aim = 0

File.foreach("input.txt") do |movement|
	direction, magnitude = movement.split(" ")

	case direction
	when "forward"
	    horizontal += magnitude.to_i
		depth += aim * magnitude.to_i
	when "up"
	    aim -= magnitude.to_i
	when "down"
	    aim += magnitude.to_i
	end
end

puts horizontal*depth
