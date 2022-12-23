screen = []
cycle = 0
x = 1

File.foreach("input.txt") do |line|
    op, num = line.strip.split

    (1..2).each do |n|
        if n == 1 || op == "addx"
          cycle += 1
          screen << ((x - (cycle - 1) % 40).abs > 1 ? "  " : "██")
        end
    end

    x += num.to_i if op == "addx"
end

puts screen.each_slice(40).map { |row| row.join }
