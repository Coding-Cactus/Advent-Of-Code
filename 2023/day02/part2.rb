c = File.foreach("input.txt").reduce(0) do |count, line|
  maxes = Hash.new(0)
  _, list = line.strip.split(":")
  list = list.split("; ")

  list.each do |draw|
    shapes = draw.split(", ")

    shapes.each do |shape|
      num, colour = shape.split(" ")
      maxes[colour] = [num.to_i, maxes[colour]].max
    end
  end

  count + maxes.reduce(1) { |pr, (_, v)| pr * v }
end

puts c
