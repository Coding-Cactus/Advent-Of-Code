require "set"

def solve(lines)
  lines.map do|line|
    lights, buttons, _ = line.match(/\[(.+)\] (.*) {(.*)}/).captures
    lights = lights.chars.each_with_index.reduce(0) { |n, (l, i)| n + 2**i * (l == "#" ? 1 : 0) }
    buttons = buttons.split.map { |b| b.scan(/\d+/).map(&:to_i).reduce(0) { |n, i| n + 2**i } }

    presses = 0
    states = Set[0]
    until states.include?(lights)
      presses += 1
      new_states = Set[]
      states.each do |state|
        buttons.each do |button|
          new_states << (state ^ button)
        end
      end
      states = new_states
    end
    presses
  end.sum
end
