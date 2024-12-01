def solve(lines)
  a = Hash.new(0)
  b = []

  lines.each do |line|
    x, y = line.split.map(&:to_i)
    a[x] += 1
    b << y
  end

  b.reduce(0) { |s, e| s + a[e] * e }
end
