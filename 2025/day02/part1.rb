def num_len(n) = n.to_s.length

def solve(lines)
  result = 0
  lines.join.split(",").each do |range|
    left, right = range.split("-").map(&:to_i)

    lh = left / 10**(num_len(left) / 2.0).ceil
    rh = right / 10**(num_len(right) / 2.0).floor

    lh.upto(rh) do |h|
      n = h * 10**(num_len(h)) + h
      result += n if n.between?(left, right)
    end
  end

  result
end
