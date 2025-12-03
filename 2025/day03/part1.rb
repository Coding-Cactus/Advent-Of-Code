def solve(lines)
  lines.map do |l|
    l = l.chars.map(&:to_i)
    a = l[...-1].max
    i = l.index(a) + 1
    a*10 + l[i..].max
  end.sum
end
