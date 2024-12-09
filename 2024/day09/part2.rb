def insert_gap(gaplen, gapptr, gaps)
  x1, x2 = gapptr, gapptr + gaplen - 1
  new_gap = [0, 0]
  inserted = false

  new_gaps = []
  gaps.each do |gap|
    len, ptr = gap
    y1, y2 = ptr, ptr + len - 1
    if (x1 <= y1 && x2 >= y1) || (y1 < x1 && y2 >= x1)
      x1 = [x1, y1].min
      x2 = [y2, x2].max

      new_gaps << new_gap unless inserted
      inserted = true
    else
      new_gaps << gap
    end
  end

  new_gap[0], new_gap[1] = x2 - x1 + 1, x1
  new_gaps
end

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
      gaps = insert_gap(flen, fptr, gaps)

      gap[0] = gaplen - flen
      gap[1] = gapptr + flen

      break
    end
  end

  files.reduce(0) { |sum, (len, id, ptr)| sum + id * (ptr...(len+ptr)).sum }
end
