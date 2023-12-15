boxes = Array.new(256) { [] }

File.foreach("input.txt").each do |line|
  line.strip.split(",").each do |step|
    if step[-1] == "-"
      box = step[...-1].chars.reduce(0) { |c, chr| (c + chr.ord) * 17 % 256 }

      boxes[box].reject! { |(lens, _)| lens == step[...-1] }
    else
      id, f_length = step.split("=")

      box = id.chars.reduce(0) { |c, chr| (c + chr.ord) * 17 % 256 }
      f_length = f_length.to_i

      replaced = false
      boxes[box].map! do |(lens, focal)|
        if lens == id
          replaced = true
          [id, f_length]
        else
          [lens, focal]
        end
      end

      boxes[box] << [id, f_length] unless replaced
    end
  end
end

power = boxes.each_with_index.reduce(0) do |pwr, (box, i1)|
  pwr + box.each_with_index.reduce(0) { |c, ((_, f_len), i2)| c + (i1 + 1) * (i2 + 1) * f_len }
end

puts power
