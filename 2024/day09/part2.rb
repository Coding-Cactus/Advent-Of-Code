def solve(lines)
  gaps = []
  files = []
  cum_i = 0
  lines.first.chars.each_with_index do |v, i|
    if (i % 2).zero?
      files << [v.to_i, i / 2, cum_i]
    else
      gaps << [v.to_i, cum_i]
    end
    cum_i += v.to_i
  end

  files.reverse.each do |file|
    flen, _, fptr = file

    gaps.each do |gap|
      gaplen, gapptr = gap

      break if gapptr > fptr
      next if gaplen < flen

      file[2] = gapptr

      gap[0] = gaplen - flen
      gap[1] = gapptr + flen

      break
    end
  end

  files.reduce(0) { |sum, (len, id, ptr)| sum + id * (ptr...(len+ptr)).sum }
end
