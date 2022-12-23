require "set"

head = [0, 0]
tail = [0, 0]

seen = Set[]

File.foreach("input.txt") do |line|
    dir, count = line.strip.split

    count.to_i.times do
        d = ["U", "R", "D", "L"].index(dir)

        head[0] += [0, 1, 0, -1][d]
        head[1] += [-1, 0, 1, 0][d]

        if (tail[0] - head[0]).abs > 1 || (tail[1] - head[1]).abs > 1
            tail[0] += head[0] <=> tail[0]
            tail[1] += head[1] <=> tail[1]
        end

        seen << tail
    end
end

puts seen.length
