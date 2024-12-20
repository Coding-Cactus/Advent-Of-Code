def combo(operand, a, b, c)
  case operand
  when 4 then a
  when 5 then b
  when 6 then c
  else operand
  end
end

def solve(lines)
  a = lines[0].split(": ")[1].to_i
  b = lines[1].split(": ")[1].to_i
  c = lines[2].split(": ")[1].to_i

  instructions = lines[4].split(": ")[1].split(",").map(&:to_i)

  ip = 0
  out = []
  until ip >= instructions.length
    opcode, operand = instructions[ip], instructions[ip + 1]

    case opcode
    when 0 then a /= 2 ** combo(operand, a, b, c)
    when 1 then b ^= operand
    when 2 then b = combo(operand, a, b, c) % 8
    when 3 then ip = a.zero? ? ip : operand - 2
    when 4 then b ^= c
    when 5 then out << combo(operand, a, b, c) % 8
    when 6 then b = a / 2 ** combo(operand, a, b, c)
    when 7 then c = a / 2 ** combo(operand, a, b, c)
    end

    ip += 2
  end

  out.join(",")
end
