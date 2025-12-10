def area(u, v) = ((v[0] - u[0]).abs + 1) * ((v[1] - u[1]).abs + 1)

def solve(lines)
  area(*lines.map { |l| l.split(",").map(&:to_i) }.combination(2).sort_by { |u, v| area(u, v) }.last)
end
