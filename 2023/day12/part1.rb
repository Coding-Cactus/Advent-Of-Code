count = File.foreach("input.txt").reduce(0) do |sum, line|
  conditions, groups = line.strip.split
  groups = groups.split(",").map(&:to_i)

  possibilities = { [0, 0] => 1 } # { [group_index, current_group_length] => count }
  conditions.chars.each do |char|
    new_possibilities = Hash.new(0)

    if %w[. ?].include?(char)
      possibilities.each { |(gi, gl), c| new_possibilities[[gl == 0 ? gi : gi + 1, 0]] += c if gl == 0 || gl == groups[gi] }
    end

    if %w[# ?].include?(char)
      possibilities.each { |(gi, gl), c| new_possibilities[[gi, gl + 1]] += c }
    end

    possibilities = new_possibilities.select { |(gi, gl), _| (gi == groups.length && gl == 0) || (gi < groups.length && gl <= groups[gi])  }
  end

  sum + possibilities
          .select { |(g_i, g_l), _| (g_i == groups.length - 1 && g_l == groups[-1]) || (g_i == groups.length && g_l == 0) }
          .reduce(0) { |c, (_, v)| c + v }
end

puts count
