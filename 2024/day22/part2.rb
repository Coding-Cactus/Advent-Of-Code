def solve(lines)
  seq_sums = Hash.new(0)

  lines.each do |line|
    seqs = {}

    num = line.to_i

    last = num
    last4_change = [nil, nil, nil, nil]
    2000.times do |n|
      num ^= num * 64
      num %= 16777216

      num ^= num / 32
      num %= 16777216

      num ^= num * 2048
      num %= 16777216

      last4_change.shift
      last4_change << num % 10 - last
      last = num % 10

      seqs[last4_change.clone] = last if n >= 3 && !seqs.include?(last4_change)
    end

    seqs.each { |seq, banan| seq_sums[seq] += banan }
  end

  seq_sums.values.max
end
