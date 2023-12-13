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
      if (1..li).all? { |dl| li + dl - 1 >= lines.length || lines[li - dl] == lines[li + dl - 1] }
        reflection = li * (i == 0 ? 100 : 1)
        break
      end
    end

    break unless reflection.nil?
  end

  t + reflection
end

puts total
