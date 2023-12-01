count = 0

File.foreach("input.txt") do |line|
  line = line.strip
  min = 999999999
  max = -1
  min_i = max_i = nil
  words = %w[1 2 3 4 5 6 7 8 9 one two three four five six seven eight nine]

  [1, 3, 4, 5].each_with_index do |len|
    (0..(line.length - len)).to_a.each do |i1|
      str = line[i1...(i1 + len)]

      if words.include?(str)
        if i1 < min
          min = i1
          min_i = words.index(str)
        end

        if i1 > max
          max = i1
          max_i = words.index(str)
        end
      end
    end
  end

  count += (1..9).to_a[min_i % 9] * 10 + (1..9).to_a[max_i % 9]
end

puts count
