def solve(lines)
  lines.map do |line|
    num = line.to_i
    2000.times do
      num ^= num * 64
      num %= 16777216

      num ^= num / 32
      num %= 16777216

      num ^= num * 2048
      num %= 16777216
    end

    num
  end.sum
end
