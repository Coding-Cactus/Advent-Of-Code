def solve(lines)
  start = nil
  lines.each_with_index do |line, y|
    x = line.index("S")
    start = Complex(x, y) unless x.nil?
  end

  total = 0
  beams = Hash.new(0)
  beams[start] += 1
  until beams.empty?
    new_beams = Hash.new(0)
    beams.each do |beam, count|
      new = beam + 1i
      if new.imag >= lines.length
        total += count
        next
      end

      if lines[new.imag][new.real] == '.'
        new_beams[new] += count
      else
        left = new - 1
        right = new + 1
        new_beams[left] += count if left.real >= 0
        new_beams[right] += count if right.real < lines[0].length
      end
    end
    beams = new_beams
  end
  total
end
