def solve(lines)
  fresh = []
  available = []
  section1 = true
  lines.each do |line|
    if section1
      if line.empty?
        section1 = false
      else
        l, r = line.split("-").map(&:to_i)
        fresh << (l..r)
      end
    else
      available << line.to_i
    end
  end

  available.count { |a| fresh.any? { |r| r.include?(a) } }
end
