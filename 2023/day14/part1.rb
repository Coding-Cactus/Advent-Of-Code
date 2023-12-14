rocks_per_line = Hash.new(0)
bottom_of_column = Hash.new(-1)
y = 0

File.foreach("input.txt").each do |line|
  line.strip.chars.each_with_index do |rock, x|
    if rock == "#"
      bottom_of_column[x] = y
    elsif rock == "O"
      bottom_of_column[x] += 1
      rocks_per_line[bottom_of_column[x]] += 1
    end
  end

  y += 1
end

puts rocks_per_line.reduce(0) { |t, (_y, c)| t + (y - _y) * c }
