sum = 0
elves = []

File.foreach("input.txt") do |line|
    if elves.length < 2
        elves << line.strip.split("")
        next
    end

    elves << line.strip.split("")

    c = elves.reduce { |i, items| i & items }[0]

    priority = c.ord - 96
    priority += 58 if priority < 1

    sum += priority

    elves = []
end

puts sum
