maps = []
seeds = []

first = true
new_map = false
File.foreach("input.txt") do |line|
  if first
    line.strip.split(": ")[1].split.each_slice(2) { |a, b| seeds<< [a.to_i, a.to_i + b.to_i - 1] }
    first = false
  elsif line == "\n"
    new_map = true
  elsif new_map
    maps << []
    new_map = false
  else
    dest, src, len = line.strip.split.map(&:to_i)
    maps[-1] << [[src, src + len - 1], dest - src]
  end
end

min = 999999999999999
seeds.each do |s_range|
  s_ranges = [s_range]
  maps.each do |map|
    modified_range = []
    same_num_ranges = s_ranges
    map.each do |(left, right), modifier|
      s_ranges.each do |s_left, s_right|
        i_left, i_right = [s_left, left].max, [s_right, right].min

        new_same_num_ranges = []
        same_num_ranges.each do |r_left, r_right|
          _left = [r_left, i_left].max
          _right = [r_right, i_right].min

          if _left > _right
            new_same_num_ranges << [r_left, r_right]
          else
            new_same_num_ranges << [r_left, _left - 1] if r_left <= _left - 1
            new_same_num_ranges << [_right + 1, r_right] if _right + 1 <= r_right
          end
        end
        same_num_ranges = new_same_num_ranges

        modified_range << [i_left + modifier, i_right + modifier] if i_left <= i_right
      end
    end

    s_ranges = modified_range + same_num_ranges
  end

  s_ranges.each { |left, _| min = [min, left].min }
end

puts min
