def solve(lines)
  lines.map do |l|
    l = l.chars.map(&:to_i)
    max_i = l.length-1

    i, jolt_num = 0, 12
    (0...jolt_num).reduce(0) do |acc, j|
      n = l[i..(max_i-(jolt_num-j-1))].max
      i = i + l[i..].index(n) + 1
      acc*10 + n
    end
  end.sum
end
