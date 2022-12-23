fish = Hash.new(0)
File.open("input.txt") { |file| file.read.strip.split(",").map { |n| n.to_i }.each { |days| fish[days] += 1 } }

80.times do
	new = Hash.new(0)
	day_6s = 0
	new_fish = 0
    fish.each do |days, num|
		days -= 1
	    if days == -1
			day_6s += num
			new_fish += num
		end
        new[days] = num unless days == -1
	end
    new[6] += day_6s
    new[8] = new_fish

	fish = new
end

puts fish.reduce(0) { |total, (_, num)| total + num }
