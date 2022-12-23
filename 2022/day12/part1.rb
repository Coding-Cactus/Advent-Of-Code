start = []
_end  = []
grid  = []
l = 0

File.foreach("input.txt") do |line|
    grid << line.split("").each_with_index.map do |h, i|
        if h == "S"
            start = [i, l]
            h = "a"
        end
        if h == "E"
            _end  = [i, l]
            h = "z"
        end
        [h.ord, start == [i, l] ? 0 : 9999999999]
    end

    l += 1
end

paths = [start]
until paths.length == 0
    new_paths = []
    paths.each do |x, y|
        [[1, 0], [0, 1], [-1, 0], [0, -1]].each do |dx, dy|
            new_x, new_y = x + dx, y + dy

            next if new_x < 0 || new_y < 0 || grid[new_y].nil? || grid[new_y][new_x].nil?

            height, count = grid[y][x]
            new_height, new_count = grid[new_y][new_x]

            if new_height - 1 <= height && count + 1 < new_count
                grid[new_y][new_x][1] = count + 1
                new_paths << [new_x, new_y]
            end
        end
    end
    paths = new_paths
end

puts grid[_end[1]][_end[0]][1]
