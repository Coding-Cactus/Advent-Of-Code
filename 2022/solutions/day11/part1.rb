class Monkey
    attr_accessor :items, :op, :modifier, :test, :true_dest, :false_dest

    def initialize
        @items = []
        @op = nil
        @modifier = nil
        @test = nil
        @true_dest = nil
        @false_dest = nil
    end

    def inspect(item)
        case @op
        when "+"
            item + @modifier
        when "-"
            item - @modifier
        when "*"
            item * @modifier
        when "/"
            item / @modifier.to_f
        when "^"
            item ** @modifier
        end
    end
end

monkeys = [Monkey.new]
File.foreach("../../inputs/day11.txt") do |line|
    if line == "\n"
        monkeys << Monkey.new
        next
    end

    next unless line[0] == " "

    type, data = line.strip.split(": ")

    case type
    when "Starting items"
        monkeys[-1].items = data.split(", ").map(&:to_i)
    when "Operation"
        op, mod = data.split[-2..-1]

        if mod == "old"
            op = "^"
            mod = 2
        end

        monkeys[-1].op = op
        monkeys[-1].modifier = mod.to_i
    when "Test"
        monkeys[-1].test = data.split[-1].to_i
    when "If true"
        monkeys[-1].true_dest = data.split[-1].to_i
    when "If false"
        monkeys[-1].false_dest = data.split[-1].to_i
    end
end


counts = Array.new(monkeys.length) { 0 }

20.times do
    monkeys.each_with_index do |monkey, mi|
        monkey.items.each_index do |i|
            monkey.items[i] = monkey.inspect(monkey.items[i])
            counts[mi] += 1

            monkey.items[i] /= 3

            monkeys[monkey.items[i] % monkey.test == 0 ? monkey.true_dest : monkey.false_dest].items << monkey.items[i]
        end
        monkey.items = []
    end
end

s = counts.sort
puts s[-2] * s[-1]
