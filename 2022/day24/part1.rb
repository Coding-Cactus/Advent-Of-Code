require "set"

blizzards = Hash.new { |h, k| h[k] = [] }
y = 0
start_x = end_x = 0
right_edge = 0
bottom_edge = 0
last_line = nil
File.foreach("input.txt") do |line|
    if y == 0
        start_x = line.index(".")
    end

    last_line = line

    line.strip.chars.each_with_index do |c, x|
        blizzards[[x, y]] << c if c != "." && c != "#"
    end

    right_edge = line.strip.length - 1

    y += 1
end
bottom_edge = y - 1
end_x = last_line.index(".")

round = 0
done = false
states = [[start_x, 0]]
until done
    round += 1

    new_blizzards = Hash.new { |h, k| h[k] = [] }
    blizzards.each do |(x, y), directions|
        directions.each do |d|
            _x, _y = x, y
            dx = { "^" => 0, "v" => 0, "<" => -1, ">" => 1 }[d]
            dy = { "^" => -1, "v" => 1, "<" => 0, ">" => 0 }[d]

            _x, _y = _x + dx, _y + dy

            _x = 1 if _x == right_edge
            _x = right_edge - 1 if _x == 0

            _y = 1 if _y == bottom_edge
            _y = bottom_edge - 1 if _y == 0

            new_blizzards[[_x, _y]] << d
        end
    end

    blizzards = new_blizzards

    new_states = Set[]
    states.each do |x, y|
        new_states << [x, y] if blizzards[[x, y]] == []

        [[0, -1], [1, 0], [0, 1], [-1, 0]].each do |dx, dy|
            _x, _y = x + dx, y + dy
            if _y == bottom_edge && _x == end_x
                done = true
                break
            end

            new_states << [_x, _y] if _x.between?(1, right_edge - 1) && _y.between?(1, bottom_edge - 1) && blizzards[[_x, _y]] == []
        end

        break if done
    end

    states = new_states
end

puts round
