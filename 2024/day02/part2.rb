def safe?(nums)
  dir = nums[0] <=> nums[1]
  nums.zip(nums[1..]).all? { |a, b| ((a <=> b) == dir && (a - b).abs.between?(1, 3)) || b.nil? }
end

def solve(lines)
  lines.select do |line|
    nums = line.split.map(&:to_i)
    (0...nums.length).any? { |i| safe?(nums[0...i] + nums[(i+1)..]) }
  end.length
end
