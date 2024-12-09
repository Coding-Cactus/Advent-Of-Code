def solve(lines)
  line = lines.first.chars.each_with_index.map { |v, i| [v.to_i, i/2] }

  i = 0
  total = 0
  head = 0
  tail = line.length - 1
  until head > tail
    elem, id = line[head]
    elem.times do
      total += i * id
      i += 1
    end
    head += 1

    break if head > tail

    hval, _ = line[head]
    until hval == 0 || head > tail
      tval, tid = line[tail]

      num = [hval, tval].min
      num.times do
        total += i * tid
        i += 1
      end

      hval -= num
      line[tail][0] -= num

      tail -= 2 if num == tval
    end
    head += 1
  end

  total
end
