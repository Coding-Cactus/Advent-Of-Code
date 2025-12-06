def solve(lines)
  lines.map(&:split).transpose.map do |calc|
    calc[...-1].map(&:to_i).reduce(calc[-1])
  end.sum
end
