def solve(lines)
  dial = 50
  lines.map do |line|
    dir, num = line[0], line[1..].to_i
    dir = dir == "L" ? -1 : 1
    dial = (dir * num + dial) % 100
    dial.zero? ? 1 : 0
  end.sum
end
