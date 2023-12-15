total = File.foreach("input.txt").reduce(0) do |t, line|
  t + line.strip.split(",").reduce(0) do |_t, step|
    _t + step.chars.reduce(0) { |c, chr| (c + chr.ord) * 17 % 256 }
  end
end

puts total
