require "set"

def area(u, v) = ((v.real - u.real).abs + 1) * ((v.imag - u.imag).abs + 1)

def solve(lines)
  reds = lines.map { |l| Complex(*l.split(",").map(&:to_i)) }

  greens = (reds + [reds.first]).each_cons(2).map do |u, v|
    dir = v - u
    size = dir.abs
    dir = Complex(dir.real / size, dir.imag / size)
    (0..size).map { |x| u + dir*x }
  end.flatten(1)

  _a = 0
  reds.combination(2).sort_by { |u, v| area(u, v) }.reverse.each do |u, v|
    p _a if (_a += 1) % 100 == 0
    x_min = [u.real, v.real].min + 1
    x_max = [u.real, v.real].max - 1
    y_min = [u.imag, v.imag].min + 1
    y_max = [u.imag, v.imag].max - 1
    next if greens.any? { |r| r.real.between?(x_min, x_max) && r.imag.between?(y_min, y_max) }
    p [u, v]
    return area(u, v)
  end
end
