def solve(lines)
  available = []
  lines[0].split(", ").each { |pattern| available << pattern }

  lines[2..].reduce(0) do |sum, pattern|
    possibilities = Array.new(pattern.length+1) { 0 }
    possibilities[0] = 1
    1.upto(pattern.length) do |l|
      available.each { |p| possibilities[l] += possibilities[l-p.length] if p == pattern[(l-p.length)...l] }
    end
    sum + possibilities[-1]
  end
end
