def solve(lines)
  max_line_len = lines.map(&:length).max
  lines.map { |l| (l + " "*(max_line_len-l.length)).chars }.transpose.slice_when { |_, b| b == ([" "]*lines.length) }.map do |nums|
    nums -= [[" "]*lines.length]
    op = nums.first.last
    nums[0] = nums.first[...-1]
    nums.map(&:join).map(&:to_i).reduce(op)
  end.sum
end
