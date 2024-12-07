def solve(lines)
  lines.reduce(0) do |sum, line|
    total, nums= line.split(": ")
    total = total.to_i
    nums = nums.split.map(&:to_i)

    done = false
    stack = [[0, nums]]
    until done || stack.empty?
      tmp, remaining = stack.pop

      mult = tmp * remaining[0]
      done = true if mult == total
      stack << [mult, remaining[1..]] if mult < total && remaining.length > 1

      plus = tmp + remaining[0]
      done = true if plus == total
      stack << [plus, remaining[1..]] if plus < total && remaining.length > 1

      concat = (tmp.to_s + remaining[0].to_s).to_i
      done = true if concat == total
      stack << [concat, remaining[1..]] if concat < total && remaining.length > 1
    end

    done ? sum + total : sum
  end
end
