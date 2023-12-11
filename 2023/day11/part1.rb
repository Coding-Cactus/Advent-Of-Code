y = 0
galaxies = []
empty_columns = []
File.foreach("input.txt") do |line|
  empty_columns = (0...line.strip.length).to_a if y == 0

  empty = true
  line.strip.chars.each_with_index do |e, x|
    if e == "#"
      galaxies << [x, y]
      empty = false
      empty_columns.delete(x)
    end
  end

  y += empty ? 2 : 1
end

galaxies.map! { |x, y| [x + empty_columns.select { |_x| _x < x }.length, y] }

sum = 0
galaxies.each_with_index do |(x1, y1), i|
  galaxies[(i + 1)..].each do |x2, y2|
    sum += (x1 - x2).abs + (y1 - y2).abs
  end
end

puts sum
