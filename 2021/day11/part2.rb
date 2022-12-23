octopi = []
File.foreach("input.txt") { |line|	octopi << line.strip.split("").map { |octopus| octopus.to_i } }

step = 0
all_flashed = false
until all_flashed do
	flash = []
	octopi.each_with_index do |row, y|
		row.each_with_index do |_, x|
			octopi[y][x] += 1
			flash << [x, y] if octopi[y][x] > 9
		end
	end

	flashed = []
	until flash.length == 0
		new_flash = []
		flash.each do |x, y|
			next if flashed.include?([x, y])

			above = y-1
			below = y+1
			left  = x-1
			right = x+1

			if above >= 0
				octopi[above][x] += 1
				new_flash << [x, above] if octopi[above][x] > 9

				if left >= 0
					octopi[above][left] += 1
					new_flash << [left, above] if octopi[above][left] > 9
				end

				if right < octopi[above].length
					octopi[above][right] += 1
					new_flash << [right, above] if octopi[above][right] > 9
				end
			end

			if below < octopi.length
				octopi[below][x] += 1
				new_flash << [x, below] if octopi[below][x] > 9

				if left >= 0
					octopi[below][left] += 1
					new_flash << [left, below] if octopi[below][left] > 9
				end

				if right < octopi[below].length
					octopi[below][right] += 1
					new_flash << [right, below] if octopi[below][right] > 9
				end
			end

			if left >= 0
				octopi[y][left] += 1
				new_flash << [left, y] if octopi[y][left] > 9
			end

			if right < octopi[y].length
				octopi[y][right] += 1
				new_flash << [right, y] if octopi[y][right] > 9
			end

			flashed << [x, y]
		end
		flash = []
		new_flash.each { |o| flash << o unless flashed.include?(o) || flash.include?(o) }
	end

	flashed.each do |x, y|
		octopi[y][x] = 0
	end

	all_flashed = true if flashed.length == octopi.length * octopi[0].length

	step += 1
end

puts step
