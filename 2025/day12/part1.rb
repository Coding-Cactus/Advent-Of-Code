def solve(lines)
  shapes = lines.join("\n").split("\n\n")[...-1].map { |shape| shape.count("#") }
  lines.join("\n").split("\n\n").last.split("\n").count do |l|
    dims, nums = l.split(": ")
    dims, nums = dims.split("x").map(&:to_i), nums.split.map(&:to_i)
    dims[0] * dims[1] >= nums.each_with_index.map { |num, i| num * shapes[i] }.sum
  end
end
