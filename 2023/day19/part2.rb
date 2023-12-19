# splits range based on comparison
def split_range((l, r), gt, num) # -> [fail_range[], success_range[]]
  if gt
    return [[l, r], [0, 0]] if num > r
    return [[0, 0], [l, r]] if num <  l
    [[l, num], [num + 1, r]]
  else
    return [[0, 0], [l, r]] if num > r
    return [[l, r], [0, 0]] if num < l
    [[num, r], [l, num - 1]]
  end
end

def solve(lines)
  workflows = {}

  lines.each do |line|
    break if line == ""

    name, conditions = line[...-1].split("{")
    conditions = conditions.split(",").map do |c|
      gt = c.include?(">")
      c, res = c.split(":")
      field, num = c.split(gt ? ">" : "<")

      num.nil? ? [nil, nil, nil, field] : ["xmas".index(field), gt, num.to_i, res]
    end

    workflows[name] = conditions
  end

  combs = 0
  part_ranges = [["in", [[1, 4000], [1, 4000], [1, 4000], [1, 4000]]]]
  until part_ranges.empty?
    workflow, ranges = part_ranges.pop

    workflows[workflow].each do |field, gt, num, res|
      success_ranges = ranges.clone

      unless field.nil?
        fail_range, success_range = split_range(ranges[field], gt, num)

        ranges[field] = fail_range
        success_ranges[field] = success_range
      end

      if field.nil? || (!field.nil? && success_ranges[field] != [0, 0]) # dont do anything with the successes if there are no successful possibilities
        if res == "A"
          combs += success_ranges.reduce(1) { |acc, (l, r)| acc * (r - l + 1) }
        elsif res != "R"
          part_ranges.unshift([res, success_ranges])
        end
      end

      break if !field.nil? && ranges[field] == [0, 0] # don't look at rest of conditions because every possibility went through current condition
    end
  end

  combs
end
