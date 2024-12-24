def evaluate(wire, wires)
  val = wires[wire]
  return val if val.is_a?(Integer)

  b1, op, b2 = val
  b1, b2 = evaluate(b1, wires), evaluate(b2, wires)

  case op
  when "OR"  then wires[wire] = b1 | b2
  when "AND" then wires[wire] = b1 & b2
  when "XOR" then wires[wire] = b1 ^ b2
  else raise "Unknown op #{op}"
  end
end

def solve(lines)
  wires = {}

  lines.each do |line|
    if line.include?(":")
      name, state = line.split(": ")
      wires[name] = state.to_i
    end

    if line.include?("->")
      inp, out = line.split(" -> ")
      wires[out] = inp.split
    end
  end

  n = 0
  output = 0
  until (wires[(wire = "z" + n.to_s.rjust(2, "0"))]).nil?
    output += 2 ** n * evaluate(wire, wires)
    n += 1
  end
  output
end
