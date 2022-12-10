cycle = 0
x = 1
count = 0

File.foreach("../../inputs/day10.txt") do |line|
    op, num = line.strip.split

    (1..2).each do |n|
        if n == 1 || op == "addx"
            cycle += 1
            count += x * cycle if cycle % 40 == 20
        end
    end

    x += num.to_i if op == "addx"
end

puts count
