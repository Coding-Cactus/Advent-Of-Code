def solve(lines)
  stones = lines.first.split.map { |n| [n.to_i, 1] }

  75.times do
    new_stones = Hash.new(0)
    stones.each do |num, count|
      n = num.to_s
      if num.zero?
        new_stones[1] += count
      elsif (n.length % 2).zero?
        h = n.length / 2
        new_stones[n[...h].to_i] += count
        new_stones[n[h..].to_i] += count
      else
        new_stones[num * 2024] += count
      end
    end
    stones = new_stones
  end

  stones.reduce(0) { |s, (_, v)| s + v }
end
