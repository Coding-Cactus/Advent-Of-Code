sum = 0

File.foreach("input.txt")do |line|
    comp1, comp2 = line.strip.split("").each_slice(line.size/2).to_a
    c = (comp1 & comp2)[0]

    priority = c.ord - 96
    priority += 58 if priority < 1

    sum += priority
end

puts sum
