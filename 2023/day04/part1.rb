c = File.foreach("input.txt").reduce(0) do |count, line|
  winning, scratched = line.strip.split(": ")[1].split(" | ").map(&:split)

  count + (2 ** ((winning & scratched).length - 1)).floor
end

puts c
