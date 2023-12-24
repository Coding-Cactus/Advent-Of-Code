# takes a few hours, will rewrite at some point

require "set"
require "matrix"
require "bigdecimal"

def diagonal(n)
  sequences = []

  0.upto(n) do |v1|
    0.upto(n - v1) do |v2|
      v3 = n - v1 - v2
      sequences << [v1, v2, v3]
      sequences << [v1, v2, -v3]   unless v3.zero?
      sequences << [v1, -v2, v3]   unless v2.zero?
      sequences << [v1, -v2, -v3]  unless v2.zero? || v3.zero?
      sequences << [-v1, v2, v3]   unless v1.zero?
      sequences << [-v1, v2, -v3]  unless v1.zero? || v3.zero?
      sequences << [-v1, -v2, v3]  unless v1.zero? || v2.zero?
      sequences << [-v1, -v2, -v3] unless v1.zero? || v2.zero? || v3.zero?
    end
  end

  sequences
end


lines = File.foreach("input.txt").map(&:strip)

hail = lines[...3].map do |line|
  pos, vel = line.split(" @ ")
  xn, yn, zn    = pos.split(", ").map(&:to_i)
  vxn, vyn, vzn = vel.split(", ").map(&:to_i)

  [xn, yn, zn, vxn, vyn, vzn]
end

hail0, hail1, hail2 = hail

x0, y0, z0, vx0, vy0, vz0 = hail0
x1, y1, z1, vx1, vy1, vz1 = hail1
x2, y2, z2, vx2, vy2, vz2 = hail2

diagonal_i = 0

loop do
  p diagonal_i
  d = diagonal(diagonal_i)
  diagonal_i += 1

  d.each do |vx, vy, vz|
    coeffs = Matrix[
      [1, 0, 0, vx - vx0,        0],
      [0, 1, 0, vy - vy0,        0],
      [0, 0, 1, vz - vz0,        0],
      [1, 0, 0,        0, vx - vx1],
      [0, 1, 0,        0, vy - vy1]
    ]

    rhs = Matrix[
      [x0],
      [y0],
      [z0],
      [x1],
      [y1]
    ]

    next if coeffs.determinant == 0

    x, y, z, t0, t1 = (coeffs.inverse * rhs).each.to_a.map(&:to_i)

    next if z + vz * t1 != z1 + vz1 * t1

    coeffs = Matrix[
      [1, 0, 0, vx - vx1,        0],
      [0, 1, 0, vy - vy1,        0],
      [0, 0, 1, vz - vz1,        0],
      [1, 0, 0,        0, vx - vx2],
      [0, 1, 0,        0, vy - vy2]
    ]

    rhs = Matrix[
      [x1],
      [y1],
      [z1],
      [x2],
      [y2]
    ]

    next if coeffs.determinant == 0

    _x, _y, _z, _t1, t2 = (coeffs.inverse * rhs).each.to_a.map(&:to_i)

    return x + y + z if x == _x && y == _y && z == _z && t1 == _t1 && z + vz * t2 == z2 + vz2 * t2
  end
end
