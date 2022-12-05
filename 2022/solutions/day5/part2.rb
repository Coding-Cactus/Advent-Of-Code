stacks = []
init = true

File.foreach("../../inputs/day5.txt") do |line|
    if line == "\n"
        init = false
        next
    end
    
    if init
        items = line.scan(/.{1,4}/)
        if stacks.length == 0
            stacks = Array.new(items.length) { [] }
        end

        items.each_with_index do |item, i|
            next unless item.split("").include?("[")
            stacks[i] << item[1]
        end
    else
        _, num, _, src, _, dst = line.split
        num, src, dst = [num, src, dst].map(&:to_i)

        s = stacks[src - 1]
        stacks[dst - 1] = s[0...num] + stacks[dst - 1]
        
        num.times do
            s.delete_at(0)
        end
    end
end

puts stacks.map { |s| s[0] }.join
