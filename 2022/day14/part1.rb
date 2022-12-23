paths = []
bottom = 0
right = 0
File.foreach("input.txt") do |line|
    lines = line.strip.split(" -> ")
    lines[0...-1].each_with_index do |point, i|
        point1 = point.split(",").map(&:to_i)
        point2 = lines[i+1].split(",").map(&:to_i)
        paths << [point1, point2]

        bottom = [bottom, point1[1], point2[1]].max
        right  = [right, point1[0], point2[0]].max
    end
end

grid = Array.new(bottom+1) { Array.new(right+1) { "." } }

paths.each do |point1, point2|
    if point1[0] == point2[0]
        a = point1[1]
        until a == point2[1]
            grid[a][point1[0]] = "#"
            a += point2[1] <=> a
        end
        grid[a][point1[0]] = "#"
    else
        a = point1[0]
        until a == point2[0]
            grid[point1[1]][a] = "#"
            a += point2[0] <=> a
        end
        grid[point1[1]][a] = "#"
    end
end

units = 0
void = false
until void
    units += 1
    sand = [500, 0]
    moving = true
    while moving
        if grid[sand[1] + 1].nil? || grid[sand[1] + 1][sand[0]] != "#"
            sand[1] += 1
        elsif grid[sand[1] + 1].nil? || sand[0] - 1 > 0 && grid[sand[1] + 1][sand[0] - 1] != "#"
            sand[0] -= 1
            sand[1] += 1
        elsif grid[sand[1] + 1].nil? || grid[sand[1] + 1][sand[0] + 1] != "#"
            sand[0] += 1
            sand[1] += 1
        else
            moving = false
            grid[sand[1]][sand[0]] = "#"
        end

        if sand[1] >= grid.length
            moving = false
            void = true
        end
    end

end

puts units-1
