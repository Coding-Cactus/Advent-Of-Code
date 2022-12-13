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

count = 0
p1 = ""
li = 1
File.foreach("../../inputs/day13.txt") do |line|
    if line == "\n"
        li += 1
        p1 = ""
    elsif p1 == ""
        p1 = eval(line.strip)
    else
        p2 = eval(line.strip)    
        count += li if comp(p1, p2) == 1
    end
end

puts count
