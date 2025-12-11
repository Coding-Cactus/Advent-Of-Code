def solve(lines)
  graph = lines.map { |l| [l.split(":")[0], l.split(":")[1].split] }.to_h

  paths = 0
  current = { "you" => 1 }
  until current.empty?
    new_current = Hash.new(0)
    current.each do |k, v|
      if k == "out"
        paths += v
        next
      end
      graph[k].each { |n| new_current[n] += v }
    end
    current = new_current
  end
  paths
end
