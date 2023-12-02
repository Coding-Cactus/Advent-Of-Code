maxes = { "red" => 12, "green" => 13, "blue" => 14 }

c = File.foreach("input.txt").reduce(0) do |count, line|
  game, list = line.strip.split(":")
  game = game.gsub("Game ", "").to_i
  list = list.split("; ")

  invalid = false
  list.each do |draw|
    shapes = draw.split(", ")

    invalid = shapes.any? do |shape|
      num, colour = shape.split(" ")
      num.to_i > maxes[colour]
    end

    break if invalid
  end

  invalid ? count : count + game
end

puts c
