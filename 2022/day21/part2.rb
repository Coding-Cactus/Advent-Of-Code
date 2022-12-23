$monkeys = {}
File.foreach("input.txt") do |line|
    name, job = line.strip.split(": ")
    monkey1, op, monkey2 = job.split

    op = "=" if name == "root"
    monkey1, op = "x", nil if name == "humn"

    $monkeys[name.to_sym] = op.nil? ? monkey1 : [monkey1, op, monkey2].map(&:to_sym)
end

def form_eqn(monkey)
    monkey1, op, monkey2 = $monkeys[monkey]

    return monkey1 if op.nil?

    new = []
    new << form_eqn(monkey1)
    new << op
    new << form_eqn(monkey2)
    new
end

def calc(expr)
    lhs, op, rhs = expr

    lhs = lhs.is_a?(Array) ? calc(lhs) : lhs.to_f
    rhs = rhs.is_a?(Array) ? calc(rhs) : rhs.to_f

    eval("#{lhs} #{op} #{rhs}")
end

def contains_x?(expr)
    lhs, _, rhs = expr

    return true if lhs == "x" || rhs == "x"
    return false if lhs.is_a?(String) && rhs.nil?

    contains_x?(lhs) || contains_x?(rhs)
end

def calculate_post_op(l, op)
    case op
    when :+
        $rhs = eval("#{$rhs} - #{l}")
    when :-
        $rhs = eval("-(#{$rhs} - #{l})")
    when :*
        $rhs = eval("#{$rhs} / #{l.to_f}")
    when :/
        $rhs = eval("1 / (#{$rhs} / #{l.to_f})")
    end
end

$inverse = { :+ => :-, :- => :+, :* => :/, :/ => :* }
def solve(lhs)
    l, op, r = lhs

    if l == "x"
        $rhs = calc([$rhs, $inverse[op], r])
    elsif r == "x"
        calculate_post_op(l.is_a?(Array) ? calc(l) : l, op)
    elsif l.is_a?(String)
        calculate_post_op(l, op)
        solve(r)
    elsif r.is_a?(String)
        $rhs = eval("#{$rhs} #{$inverse[op]} #{r.to_f}")
        solve(l)
    elsif contains_x?(l)
        $rhs = eval("#{$rhs} #{$inverse[op]} #{calc(r).to_f}")
        solve(l)
    else
        calculate_post_op(calc(l), op)
        solve(r)
    end
end

lhs, _, rhs = form_eqn(:root)
lhs, rhs = [rhs, lhs] if contains_x?(rhs)
$rhs = calc(rhs)
solve(lhs)
puts $rhs.round
