p1_pos = p2_pos = nil
File.foreach("../../inputs/day21.txt") do |line|
	unless p1_pos
		p1_pos = line.strip().split(": ")[1].to_i
	else
		p2_pos = line.strip().split(": ")[1].to_i
	end
end

p1_score = 0
p2_score = 0
current_roll = 1
die_rolls = 0

until p1_score >= 1000 || p2_score >= 1000
	roll = 0
	3.times do
		die_rolls += 1
		roll += current_roll
		current_roll  = current_roll + 1 == 101 ? 1 : current_roll + 1
	end

	p1_pos = (p1_pos + roll) % 10 == 0 ? 10 : (p1_pos + roll) % 10
	p1_score += p1_pos

	break if p1_score >= 1000

	roll = 0
	3.times do
		die_rolls += 1
		roll += current_roll
		current_roll  = current_roll + 1 == 101 ? 1 : current_roll + 1
	end

	p2_pos = (p2_pos + roll) % 10 == 0 ? 10 : (p2_pos + roll) % 10
	p2_score += p2_pos
end

puts [p1_score, p2_score].min * die_rolls
