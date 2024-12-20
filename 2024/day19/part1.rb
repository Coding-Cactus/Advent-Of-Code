def possible(pattern, available) =
  pattern.empty? || available.any? { |p| pattern[...p.length] == p && possible(pattern[p.length..], available) }

def solve(lines)
  available = lines[0].split(", ")
  lines[2..].select { |pattern| possible(pattern, available) }.length
end
