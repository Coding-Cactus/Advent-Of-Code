grid = []
File.foreach("input.txt") do |line|
  grid << line.strip
end

num = ""
gear = []
gears = Hash.new { |h, k| h[k] = [] }
digits = ("0".."9").to_a
grid.each_with_index do |row, y|
  row.chars.each_with_index do |chr, x|
    if digits.include?(chr)
      num += chr

      [[0, -1], [1, 0], [0, 1], [-1, 0], [1, -1], [1, 1], [-1, 1], [-1, -1]].any? do |dx, dy|
        new_x, new_y = x + dx, y + dy
        next if new_x < 0 || new_x >= row.length || new_y < 0 || new_y >= grid.length
        gear = [new_x, new_y] if grid[new_y][new_x] == "*"
      end
    end

    if !digits.include?(chr) || x == row.length - 1
      p_num = num
      num = ""
      p_gear = gear
      gear = []

      next if p_num == "" || p_gear == []

      gears[p_gear] << p_num.to_i
    end
  end
end

puts gears.reduce(0) { |s, (_, nums)| s + (nums.length == 2 ? nums[0] * nums[1] : 0) }
