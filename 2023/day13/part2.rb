grids = [[[], []]]

File.foreach("input.txt") do |line|
  line = line.strip.chars

  if line == []
    grids << [[], []]
  else
    rows, columns = grids[-1]
    rows << line

    line.each_with_index do |c, i|
      columns << [] if columns.length == i
      columns[i] << c
    end
  end
end


total = grids.reduce(0) do |t, (rows, columns)|
  reflection = nil
  [rows, columns].each_with_index do |lines,i|
    (1...lines.length).each do |li|
      diff = (1..li).reduce(0) do |d, dl|
        left = lines[li - dl]
        right = lines[li + dl - 1]

        d + (right.nil? ? 0 : left.each_with_index.reduce(0) { |s, (le, ri)| s + (le == right[ri] ? 0 : 1) })
      end

      if diff == 1
        reflection = li * (i == 0 ? 100 : 1)
        break
      end
    end

    break unless reflection.nil?
  end

  t + reflection
end

puts total
