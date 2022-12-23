grid = []

File.foreach("input.txt") do |line|
    grid << line.strip.split("").map(&:to_i)
end

max = 0
grid.each_with_index do |row, y|
    row.each_with_index do |tree, x|
        maxes  = [0, 0, 0, 0]
        dones  = [false, false, false, false]
        coords = Array.new(4) { [x, y] }

        until dones.all? { |d| d }
            [[0, -1], [1, 0], [0, 1], [-1, 0]].each_with_index do |(dx, dy), i|
                coords[i][0] = coords[i][0] + dx
                coords[i][1] = coords[i][1] + dy

                _row = grid[coords[i][1]]
                comp_tree = coords[i][0] < 0 || coords[i][1] < 0 || _row.nil? ? nil : _row[coords[i][0]]

                maxes[i] += 1 unless dones[i] || comp_tree.nil?
                dones[i] = true if comp_tree.nil? || comp_tree >= tree
            end
        end

        max = [max, maxes.reduce(1) { |p, c| p * c }].max
    end
end

puts max
