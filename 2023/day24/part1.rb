require 'bigdecimal'

BOUNDARY_MIN = 200000000000000
BOUNDARY_MAX = 400000000000000

def solve(lines)
  lines.map do |line|
    pos, vel = line.split(" @ ")
    x, y, _   = pos.split(", ").map { |n| BigDecimal(n) }
    vx, vy, _ = vel.split(", ").map { |n| BigDecimal(n) }

    [[x, vx], [y, vy]]
  end.combination(2).reduce(0) do |count, (((x1, vx1), (y1, vy1)), ((x2, vx2), (y2, vy2)))|
    x = (vx1 * vx2 * (y2 - y1) + vy1 * vx2 * x1 - vx1 * vy2 * x2) / (vy1 * vx2 - vx1 * vy2)
    y = y1 + vy1 * (x - x1) / vx1

    t1 = (x - x1) / vx1
    t2 = (x - x2) / vx2

    count + (t1 >= 0 && t2 >= 0 && x.between?(BOUNDARY_MIN, BOUNDARY_MAX) && y.between?(BOUNDARY_MIN, BOUNDARY_MAX) ? 1 : 0)
  end
end
