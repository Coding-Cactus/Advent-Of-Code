def sort_seq(seq, before)
  seq.sort do |a, b|
    if before[a].include?(b)
      1
    elsif before[b].include?(a)
      -1
    else
      0
    end
  end
end

def solve(lines)
  before = Hash.new { |h, k| h[k] = [] }

  sum = 0

  updates = false
  lines.each do |line|
    if line == ""
      updates = true
    elsif updates
      nums = line.split(",")
      sum += nums[nums.length / 2].to_i if nums == sort_seq(nums, before)
    else
      a, b = line.split("|")
      before[b] << a
    end
  end

  sum
end
