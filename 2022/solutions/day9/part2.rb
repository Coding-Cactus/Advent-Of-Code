require "set"

parts = Array.new(10) { [0, 0] }

seen = Set[]

File.foreach("../../inputs/day9.txt") do |line|
    dir, count = line.strip.split

    count.to_i.times do
        d = ["U", "R", "D", "L"].index(dir)

        parts.each_with_index do |part, i|
            if i == 0
                part[0] += [0, 1, 0, -1][d]
                part[1] += [-1, 0, 1, 0][d]
            else
                head = parts[i-1]
        
                if (part[0] - head[0]).abs > 1 || (part[1] - head[1]).abs > 1
                    part[0] += head[0] <=> part[0]
                    part[1] += head[1] <=> part[1]
                end
        
                seen << part if i == 9
            end
        end
    end
end

puts seen.length
