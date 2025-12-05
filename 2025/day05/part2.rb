def solve(lines)
  fresh = []
  lines.each do |line|
    break if line.empty?
    fresh << line.split("-").map(&:to_i)
  end

  fresh.sort!
  new_fresh = [fresh.first]
  fresh[1..].each do  |r|
    if r.first <= new_fresh[-1].last
      new_fresh[-1] = [new_fresh[-1].first, [r.last, new_fresh[-1].last].max]
    else
      new_fresh << r
    end
  end

  new_fresh.map { |r| r.last - r.first + 1 }.sum
end
