biggest = 0
current = 0
File.foreach("input.txt") do |line|
    if line == "\n"
        biggest = [current, biggest].max
        current = 0
        else
            current += line.strip.to_i
    end
end

puts biggest
