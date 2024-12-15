require "set"

def solve(lines)
  moves = { "^" => 0 - 1i, ">" => 1 + 0i, "v" => 0 + 1i, "<" => -1 + 0i }

  robot = nil
  boxes = Set[]
  walls = Set[]
  instructions = []

  lines.each_with_index do |line, y|
    line.chars.each_with_index do |char, x|
      robot = Complex(x, y) if char == "@"
      boxes << Complex(x, y) if char == "O"
      walls << Complex(x, y) if char == "#"
      instructions << char if %w[^ > v <].include?(char)
    end
  end

  instructions.each do |instruction|
    delta = moves[instruction]

    nc = robot + delta

    next if walls.include?(nc)

    if boxes.include?(nc)
      b = nc + delta
      b += delta while boxes.include?(b)
      unless walls.include?(b)
        boxes.delete(nc)
        boxes.add(b)
      end
    end

    robot = nc unless boxes.include?(nc)
  end

  boxes.reduce(0) { |s, c| s + c.real + 100 * c.imag }
end
