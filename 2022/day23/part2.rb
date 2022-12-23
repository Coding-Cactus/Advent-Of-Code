grid = []
elves = []
y = 1
File.foreach("input.txt") do |line|
    l = line.strip.chars
    grid << ["."] + l + ["."]
    l.each_with_index { |e, x| elves << [x + 1, y] if e == "#"  }
    y += 1
end

grid.append(Array.new(grid[0].length) { "." })
grid.unshift(Array.new(grid[0].length) { "." })

round = 0
preference = %w[N S W E]
loop do
    round += 1
    proposals = Hash.new { |h, k| h[k] = [] }

    elves.each do |x, y|
        if [[0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1]].any? { |dx, dy| grid[y + dy][x + dx] == "#" }
            preference.each do |pref|
                dx = { "N" => 0, "S" => 0, "W" => -1, "E" => 1 }[pref]
                dy = { "N" => -1, "S" => 1, "W" => 0, "E" => 0 }[pref]

                empty = true
                [-1, 0, 1].each do |d|
                    if dx == 0
                        empty = false if grid[y + dy][x + d] == "#"
                    else
                        empty = false if grid[y + d][x + dx] == "#"
                    end
                end

                if empty
                    proposals[[x + dx, y + dy]] << [x, y]
                    break
                end
            end
        end
    end

    break if proposals.length == 0

    preference.rotate!

    proposals.each do |(x, y), elf|
        if elf.length == 1
            old_x, old_y = elf[0]
            elves[elves.index(elf[0])] = [x, y]
            grid[old_y][old_x] = "."
            grid[y][x] = "#"
        end
    end

    top    = left  =  9999999
    bottom = right = -9999999
    elves.each do |_x, _y|
        bottom = [bottom, _y].max
        right  = [right,  _x].max
        top    = [top,    _y].min
        left   = [left,   _x].min
    end

    n_left   = left == 0
    n_right  = right == grid[0].length - 1
    n_top    = top == 0
    n_bottom = bottom == grid.length - 1

    if n_left || n_right
        grid.map! do |row|
            row.unshift(".") if n_left
            row.append(".") if n_right
            row
        end
    end

    grid.unshift(Array.new(grid[0].length) { "." }) if n_top
    grid.append(Array.new(grid[0].length) { "." }) if n_bottom

    elves.map! { |_x, _y| [n_left ? _x + 1 : _x, n_top ? _y + 1 : _y] } if n_top || n_left
end

puts round
