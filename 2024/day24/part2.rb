def solve(lines)
  start = {}
  wires = {}
  lines.each do |line|
    start[line.split(": ")[0]] = true if line.include?(":")

    if line.include?("->")
      inp, out = line.split(" -> ")
      wires[out] = inp.split
    end
  end

  gates = Hash.new { |h, k| h[k] = [nil, [], []] } # { output => [op, inputnames, nextgates] }
  wires.each do |out, (inp1, op, inp2)|
    gates[out][0] = op
    gates[out][1] = [inp1, inp2]
    [inp1, inp2].each { |inp| gates[inp][2].push(out) }
  end

  bad = []
  gates.each do |out, (op, inputs, next_gs)|
    if next_gs.empty?
      if out == "z45"
        bad.push(out) unless op == "OR"
      elsif op != "XOR" || inputs.any? { |inp| start.include?(inp) && inp[1..] != out[1..] }
        bad.push(out)
      else
        inputs.each do |inp|
          if gates[inp][1].any? { |i| start.include?(i) }
            bad.push(inp) unless gates[inp][0] == "XOR" || %w[x00 y00] == gates[inp][1]
          else
            bad.push(inp) unless gates[inp][0] == "OR" || start.include?(inp)
          end
        end
      end
    elsif op == "OR"
      inputs.each { |inp| bad.push(inp) unless gates[inp][0] == "AND" }
    end
  end

  bad.sort.join(",")
end
