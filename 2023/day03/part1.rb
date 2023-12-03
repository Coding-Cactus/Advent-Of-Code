grid = []
File.foreach("input.txt") do |line|
  grid << line.strip
end

sum = 0
num = ""
adjacent = false
digits = ("0".."9").to_a
grid.each_with_index do |row, y|
  row.chars.each_with_index do |chr, x|
    if digits.include?(chr)
      num += chr

      [[0, -1], [1, 0], [0, 1], [-1, 0], [1, -1], [1, 1], [-1, 1], [-1, -1]].any? do |dx, dy|
        new_x, new_y = x + dx, y + dy
        next if new_x < 0 || new_x >= row.length || new_y < 0 || new_y >= grid.length
        adjacent = true unless grid[new_y][new_x] == "." || digits.include?(grid[new_y][new_x])
      end
    end

    if !digits.include?(chr) || x == row.length - 1
      p_num = num
      num = ""
      p_adj = adjacent
      adjacent = false

      next if p_num == "" || !p_adj

      sum += p_num.to_i
    end
  end
end

puts sum
