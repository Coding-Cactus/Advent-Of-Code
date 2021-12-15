polymer = []
insertions = {}
at_insertions = false

File.foreach("../../inputs/day14.txt") do |line|
	if at_insertions
		pair, insert = line.strip.split(" -> ")
		insertions[pair] = insert

	elsif line == "\n"
		at_insertions = true
	else
		polymer = line.strip.split("")
	end
end

pair_counts = Hash.new(0)
polymer[0...-1].each_with_index { |a, i| pair_counts[a+polymer[i+1]] += 1 }


10.times do
	new_count = Hash.new(0)
	pair_counts.each do |pair, count|
		if insertions.include?(pair)
			insertion = insertions[pair]
			
			new_count[pair[0]+insertion] += count
			new_count[insertion+pair[1]] += count
		else
			new_count[pair] += count
		end
	end
	pair_counts = new_count
end

count = Hash.new(0)
pair_counts.each { |pair, c| count[pair[0]] += c }
count[polymer[-1]] += 1

max = 0
min = 99999999999999999999999
count.each do |_, num|
	max = num if num > max
	min = num if num < min
end

puts max - min
