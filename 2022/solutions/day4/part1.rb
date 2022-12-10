count = 0

File.foreach("../../inputs/day4.txt") do |line|
    pair1, pair2 = line.strip.split(",")

    num1, num2 = pair1.split("-").map(&:to_i)
    num3, num4 = pair2.split("-").map(&:to_i)

    count += 1 if (num1 <= num3 && num2 >= num4) || (num1 >= num3 && num2 <= num4)
end

puts count
