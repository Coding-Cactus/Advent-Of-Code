game = 0
copies = Hash.new(1)

File.foreach("input.txt") do |line|
  g, nums = line.strip.split(": ")

  game = g.gsub("Card", "").to_i
  winning, scratched = nums.split(" | ").map(&:split)

  1.upto((winning & scratched).length) { |n| copies[game + n] += copies[game] }
end

puts (1..game).reduce(0) { |s, g| s + copies[g] }
