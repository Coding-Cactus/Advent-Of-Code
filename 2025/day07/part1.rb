require "set"

def solve(lines)
  start = nil
  lines.each_with_index do |line, y|
    x = line.index("S")
    start = Complex(x, y) unless x.nil?
  end

  splits = 0
  beams = Set[start]
  until beams.empty?
    new_beams = Set[]
    beams.each do |beam|
      new = beam + 1i
      next if new.imag >= lines.length

      if lines[new.imag][new.real] == '.'
        new_beams << new
      else
        splits += 1
        left = new - 1
        right = new + 1
        new_beams << left if left.real >= 0
        new_beams << right if right.real < lines[0].length
      end
    end
    beams = new_beams
  end
  splits
end
