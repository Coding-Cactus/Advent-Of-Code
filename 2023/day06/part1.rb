times = []
distances = []

first = true
File.readlines("input.txt").each do |line|
  if first
    times = line.strip.split(":")[1].split.map(&:to_i)
    first = false
  else
    distances = line.strip.split(":")[1].split.map(&:to_i)
  end
end

counts = Array.new(times.length) { 0 }
times.each_with_index do |time, i|
  1.upto(time - 1) do |n|
    counts[i] += 1 if n * (time - n) > distances[i]
  end
end

puts counts.reduce(1) { |p, n| p * n }
