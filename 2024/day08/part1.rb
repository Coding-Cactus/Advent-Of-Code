require "set"

def solve(lines)
  max_x = lines[0].length - 1
  max_y = lines.length - 1

  freqs = Hash.new { |h, k| h[k] = [] }
  lines.each_with_index do |row, y|
    row.chars.each_with_index do |char, x|
      next if char == "."
      freqs[char] << Complex(x, y)
    end
  end

  spots = Set[]
  freqs.each do |_, antennas|
    antennas.each_with_index do |c1, i|
      antennas[(i+1)..].each do |c2|
        delta = c2 - c1

        new1 = c1 - delta
        new2 = c2 + delta

        spots << new1 if new1.real.between?(0, max_x) && new1.imag.between?(0, max_y)
        spots << new2 if new2.real.between?(0, max_x) && new2.imag.between?(0, max_y)
      end
    end
  end

  spots.length
end
