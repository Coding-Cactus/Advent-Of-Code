time = []
distance = []

first = true
File.readlines("input.txt").each do |line|
  if first
    time = line.strip.split(":")[1].gsub(" ", "").to_i
    first = false
  else
    distance = line.strip.split(":")[1].gsub(" ", "").to_i
  end
end

def quadratic(a, b, c, pm) = (-b + pm * (b ** 2 - 4 * a * c) ** 0.5) / (2 * a)

puts  quadratic(1, -time, distance, 1).floor - quadratic(1, -time, distance, -1).ceil + 1
