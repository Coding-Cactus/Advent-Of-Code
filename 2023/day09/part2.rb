total = File.foreach("input.txt").reduce(0) do |t, line|
  sequence = [line.strip.split.map(&:to_i)]

  until sequence[-1].all? { |e| e.zero? }
    sequence << []
    sequence[-2][...-1].each_with_index do |e, i|
      sequence[-1] << sequence[-2][i + 1] - e
    end
  end


  t + sequence[...-1].reverse.reduce(0) { |f, s| s[0] - f }
end

puts total
