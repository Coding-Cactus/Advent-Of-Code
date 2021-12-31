p1_pos = p2_pos = nil
File.foreach("../../inputs/day21.txt") do |line|
	unless p1_pos
		p1_pos = line.strip().split(": ")[1].to_i
	else
		p2_pos = line.strip().split(": ")[1].to_i
	end
end


roll_posibilities = Hash.new(0)
1.upto(3) do |num1|
	1.upto(3) do |num2|
		1.upto(3) do |num3|
			roll_posibilities[num1+num2+num3] += 1
		end
	end
end


universes = Hash.new(0)
universes[[0, p1_pos, 0, p2_pos]] = 1
p1_wins = 0
p2_wins = 0

until universes.length == 0
	new_universes = Hash.new(0)
	universes.each do |(p1_score, p1_pos, p2_score, p2_pos), count|
		new_outcomes = Hash.new(0)

		roll_posibilities.each do |roll1, freq1|
			outcome = [p1_score, p1_pos, p2_score, p2_pos]
			outcome[1] = (p1_pos + roll1) % 10 == 0 ? 10 : (p1_pos + roll1) % 10
			outcome[0] += outcome[1]

			if outcome[0] >= 21
				p1_wins += count * freq1
			else
				roll_posibilities.each do |roll2, freq2|
					new_outcome = outcome.map { |o| o }
					new_outcome[3] = (p2_pos + roll2) % 10 == 0 ? 10 : (p2_pos + roll2) % 10
					new_outcome[2] += new_outcome[3]

					if new_outcome[2] >= 21
						p2_wins += count * freq1 * freq2
					else
						new_outcomes[new_outcome] += count * freq1 * freq2
					end
				end
			end
		end
		new_outcomes.each { |data, count| new_universes[data] += count }
	end
	universes = {}
	new_universes.each { |data, count| universes[data] = count }
end

puts [p1_wins, p2_wins].max
