count = 0

File.foreach("../../inputs/day4.txt") do |line|
    pair1, pair2 = line.strip.split(",")

    num1, num2 = pair1.split("-").map(&:to_i)
    num3, num4 = pair2.split("-").map(&:to_i)

    count += 1 unless ((num1..num2).to_a | (num3..num4).to_a).length == (num2 - num1 + 1) + (num4 - num3 + 1)
end

puts count
