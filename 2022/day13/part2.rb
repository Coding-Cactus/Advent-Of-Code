def comp(d1, d2)
    if d1.is_a?(Integer) && d2.is_a?(Integer)
        d2 <=> d1
    elsif d1.is_a?(Array) && d2.is_a?(Array)
        d1.each_index do |i|
            return -1 if d2[i].nil?

            c = comp(d1[i], d2[i])
            return c unless c == 0
        end
        d2.length <=> d1.length
    else
        d1 = [d1] if d1.is_a?(Integer)
        d2 = [d2] if d2.is_a?(Integer)

        comp(d1, d2)
    end
end

packets = [[[2]], [[6]]]
File.foreach("input.txt") do |line|
    next if line == "\n"

    packets << eval(line.strip)
end

packs = packets.sort { |a, b| -comp(a, b) }

puts (packs.index([[2]]) + 1) * (packs.index([[6]]) + 1)
