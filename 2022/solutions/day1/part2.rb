all = []
current = 0
File.foreach("../../inputs/day1.txt") do |line|
    if line == "\n"
        all << current
        current = 0
    else
        current += line.strip.to_i
    end
end

puts all[0...3].sum
