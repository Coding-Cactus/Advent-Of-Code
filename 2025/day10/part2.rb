require "z3"

def solve(lines)
  lines.map do|line|
    _, buttons, joltages = line.match(/\[(.+)\] (.*) {(.*)}/).captures
    buttons = buttons.split.map { |b| b.scan(/\d+/).map(&:to_i) }
    joltages = joltages.split(",").map(&:to_i)

    solver = Z3::Optimize.new

    button_vars = buttons.each_index.map { |i| Z3.Int((i + 97).chr) }
    button_vars.each { |v| solver.assert(v >= 0) }

    sums = Array.new(joltages.length) { [] }
    buttons.each_with_index do |button, i|
      button.each do |jolt|
        sums[jolt] << button_vars[i]
      end
    end

    sums.each_with_index do |vars, i|
      solver.assert(vars.sum == joltages[i])
    end

    solver.assert(Z3.Int("cost") == buttons.each_index.map { |i| Z3.Int((i + 97).chr) }.sum)
    solver.minimize(Z3.Int("cost"))

    if solver.check
      model = solver.model
      model[Z3.Int("cost")].to_i
    else
      puts "oops"
    end
  end.sum
end
