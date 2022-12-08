require "set"

grid = []

File.foreach("../../inputs/day8.txt") do |line|
    grid << line.strip.split("").map(&:to_i)
end

seen = Set[]

prev_y = Array.new(grid[0].length) { -1 }
grid.each_with_index do |row, y|
    prev_x = -1
    row.each_with_index do |tree, x|        
        seen << [x, y] if tree > prev_x || tree > prev_y[x]
        prev_x = [tree, prev_x].max
        prev_y[x] = [tree, prev_y[x]].max
    end
end

grid = grid.reverse.map(&:reverse)

prev_y = Array.new(grid[0].length) { -1 }
grid.each_with_index do |row, y|
    prev_x = -1
    y = grid.length - 1 - y
    row.each_with_index do |tree, x|
        x = row.length - 1 - x

        seen << [x, y] if tree > prev_x || tree > prev_y[x]
        prev_x = [tree, prev_x].max
        prev_y[x] = [tree, prev_y[x]].max
    end
end

puts seen.length
