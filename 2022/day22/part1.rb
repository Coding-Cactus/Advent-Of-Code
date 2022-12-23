grid = []
directions = []
done_map = false
File.foreach("input.txt") do |line|
    if line == "\n"
        done_map = true
        next
    end

    if done_map
        directions = line.strip.split(/(?<=[RL])/).map do |i|
            %w[R L].include?(i[-1]) ? [i[0...-1].to_i, { "R" => 1, "L" => -1 }[i[-1]]] : [i.to_i, nil]
        end
    else
        grid << line[0...-1].chars
    end
end

x, y, facing = grid[0].index("."), 0, 0
directions.each do |num, turn|
    num.times do
        next_x = x + [1, 0, -1, 0][facing]
        next_y = y + [0, 1, 0, -1][facing]

        if next_x > x && next_x >= grid[y].length
            next_x = grid[y].each_with_index.reduce(grid[y].length) { |im, (t, i)| t == " " ? im : [im, i].min }
        elsif next_x < x && (next_x < 0 || grid[y][next_x] == " ")
            next_x = grid[y].length - 1
        elsif next_y > y && (next_y >= grid.length || grid[next_y][x] == " " || grid[next_y][x].nil?)
            next_y = grid.each_with_index.reduce(grid.length) { |im, (r, i)| r[x] == " " || r[x].nil? ? im : [im, i].min }
        elsif next_y < y && (next_y < 0 || grid[next_y][x] == " " || grid[next_y][x].nil?)
            next_y = grid.each_with_index.reduce(-1) { |im, (r, i)| r[x] == " " || r[x].nil? ? im : [im, i].max }
        end

        break if grid[next_y][next_x] == "#"

        x, y = next_x, next_y
    end

    facing = (facing + turn) % 4 unless turn.nil?
end

puts (y + 1) * 1000 + (x + 1) * 4 + facing
