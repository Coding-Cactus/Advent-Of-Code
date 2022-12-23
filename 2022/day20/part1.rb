i = 0
encrypted = []
File.foreach("input.txt") do |line|
    encrypted << [line.strip.to_i, i]
    i += 1
end

l = encrypted.length
(0...l).each do |initial_i|
    current_i = encrypted.find_index { |e| e[1] == initial_i }
    num, _ = encrypted.delete_at(current_i)
    encrypted.insert((current_i + num) % (l-1), [num, initial_i])
end

zero = encrypted.find_index { |e| e[0] == 0 }
puts encrypted[(zero + 1000) % l][0] +
         encrypted[(zero + 2000) % l][0] +
         encrypted[(zero + 3000) % l][0]
