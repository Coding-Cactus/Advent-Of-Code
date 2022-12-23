$monkeys = {}
File.foreach("input.txt") do |line|
    name, job = line.strip.split(": ")
    monkey1, op, monkey2 = job.split

    $monkeys[name.to_sym] = op.nil? ? monkey1.to_i : [monkey1, op, monkey2].map(&:to_sym)
end

def calc(monkey)
    monkey1, op, monkey2 = $monkeys[monkey]

    return monkey1 if op.nil?

    case op
    when :+
        calc(monkey1) + calc(monkey2)
    when :-
        calc(monkey1) - calc(monkey2)
    when :*
        calc(monkey1) * calc(monkey2)
    when :/
        calc(monkey1) / calc(monkey2).to_f
    end
end

p calc(:root).round
