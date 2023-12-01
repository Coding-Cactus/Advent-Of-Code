count = 0

File.foreach("input.txt") do |line|
  num = line.strip.gsub(/[a-z]/, "")
  count += (num[0] + num[-1]).to_i
end

puts count
