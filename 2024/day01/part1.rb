def solve(lines)
  a = []
  b = []

  lines.each do |line|
    x, y = line.split.map(&:to_i)
    a << x
    b << y
  end

  a.sort!
  b.sort!
  a.each_index.reduce(0) { |c, i| c + (a[i] - b[i]).abs }
end
