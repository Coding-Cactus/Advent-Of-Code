x1 = x2 = y1 = y2 = nil
File.open("input.txt") do |file|
	x, y = file.read.strip.split(": ")[1].split(", ")

    x1, x2 = x.split("=")[1].split("..").map { |n| n.to_i }
    y1, y2 = y.split("=")[1].split("..").map { |n| n.to_i }
end


total = 0

-200.upto(200) do |dy|
	0.upto(200) do |dx|
		pos = [0, 0]
		d = [dx, dy]
		max = 0
		while pos[0] <= x2 && pos[1] >= y1
			if x1 <= pos[0] && pos[0] <= x2 && y1 <= pos[1] && pos[1] <= y2
				total += 1
				break
			end
		    pos[0] += d[0]
			pos[1] += d[1]
			d[0] -= 1 if d[0] > 0
			d[1] -= 1
		end
	end
end
puts total
