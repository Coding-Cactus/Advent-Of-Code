def solve(lines)
  dial = 50
  lines.map do |line|
    dir, num = line[0], line[1..].to_i
    dir = dir == "L" ? -1 : 1
    prev = (dial * dir + 100) % 100
    dial = (dir * num + dial) % 100
    (prev + num) / 100
  end.sum
end
