horizontal = depth = 0

File.foreach("../../inputs/day2.txt") do |movement|
	direction, magnitude = movement.split(" ")

	case direction
	when "forward"
	    horizontal += magnitude.to_i
	when "up"
	    depth -= magnitude.to_i
	when "down"
	    depth += magnitude.to_i
	end
end

puts horizontal*depth
