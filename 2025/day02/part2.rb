require "set"

def solve(lines)
  found = Set[]
  lines.join.split(",").each do |range|
    left, right = range.split("-").map(&:to_i)
    left_len, right_len = left.to_s.length, right.to_s.length

    1.upto(right_len / 2) do |len|
      (10**(len-1)...10**len).each do |n|
        left_len.upto(right_len) do |res_len|
          num = (n.to_s * (res_len / len)).to_i
          found << num if num.between?(left, right) && res_len / len > 1
        end
      end
    end
  end

  found.sum
end
