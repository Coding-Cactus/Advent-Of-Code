faces = Array.new(6) { [] }
parsed_faces = 0
directions = []
done_map = false
y = 0
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
        x = 0
        line[0...-1].chars.each_slice(50) do |face_line|
            unless face_line.all? { |e| e == " " }
                faces[parsed_faces + x] << face_line
                x += 1
            end
        end
        y += 1
        parsed_faces += x if y % 50 == 0
    end
end

CONNECTIONS = [ # new_face, new_facing = CONNECTIONS[current_face][current_facing]
    [[1, 0], [2, 1], [3, 0], [5, 0]],
    [[4, 2], [2, 2], [0, 2], [5, 3]],
    [[1, 3], [4, 1], [3, 1], [0, 3]],
    [[4, 0], [5, 1], [0, 0], [2, 0]],
    [[1, 2], [5, 2], [3, 2], [2, 3]],
    [[4, 3], [1, 1], [0, 1], [3, 3]]
]

x = y = facing = face = 0
directions.each do |num, turn|
    num.times do
        next_x = x + [1, 0, -1, 0][facing]
        next_y = y + [0, 1, 0, -1][facing]
        next_face, next_facing = face, facing

        if [next_x, next_y].any? { |n| n < 0 || n >= 50 }
            next_face, next_facing = CONNECTIONS[face][facing]
            case [facing, next_facing]
            when [0, 0]
                next_x = 0
            when [0, 2]
                next_y = 49 - next_y
                next_x = 49
            when [0, 3]
                next_x = next_y
                next_y = 49
            when [1, 1]
                next_y = 0
            when [1, 2]
                next_y = x
                next_x = 49
            when [2, 0]
                next_y = 49 - next_y
                next_x = 0
            when [2, 1]
                next_x = next_y
                next_y = 0
            when [2, 2]
                next_x = 49
            when [3, 0]
                next_y = next_x
                next_x = 0
            when [3, 3]
                next_y = 49
            end
        end

        break if faces[next_face][next_y][next_x] == "#"

        x, y, face, facing = next_x, next_y, next_face, next_facing
    end

    facing = (facing + turn) % 4 unless turn.nil?
end

y_mod = [0, 0, 1, 2, 2, 3]
x_mod = [1, 2, 1, 0, 1, 0]

puts (50 * y_mod[face] + y + 1) * 1000 + (50 * x_mod[face] + x + 1) * 4 + facing
