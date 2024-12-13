require "matrix"

def solve(lines)
  i = 0
  total = 0
  until i >= lines.length
    x1 = lines[i].scan(/X\+(\d+)/).first.first.to_i
    y1 = lines[i].scan(/Y\+(\d+)/).first.first.to_i
    x2 = lines[i+1].scan(/X\+(\d+)/).first.first.to_i
    y2 = lines[i+1].scan(/Y\+(\d+)/).first.first.to_i
    x3 = lines[i+2].scan(/X=(\d+)/).first.first.to_i
    y3 = lines[i+2].scan(/Y=(\d+)/).first.first.to_i
    i += 4

    coeffs = Matrix[
      [x1, x2],
      [y1, y2]
    ]

    next if coeffs.determinant.zero?

    res = Matrix[
      [x3],
      [y3]
    ]

    x, y = (coeffs.inverse * res).each.to_a.map(&:to_f)
    total += x * 3 + y if [x, y].all? { |n| n.to_i == n }
  end

  total.to_i
end
