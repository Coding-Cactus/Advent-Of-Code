strengths = %w[A K Q J T 9 8 7 6 5 4 3 2]

hands = File.foreach("input.txt").map do |line|
  hand, bid = line.strip.split
  [hand.chars, bid.to_i]
end.sort do |(hand1, _), (hand2, _)|
  uniq1 = hand1.uniq
  uniq2 = hand2.uniq

  # 1: hand1 >
  # 0: =
  # -1: hand2 >
  if (uniq2.length <=> uniq1.length) != 0
    uniq2.length <=> uniq1.length
  else
    result = 0

    case uniq1.length
    when 2
      result += 1 if uniq1.any? { |c| hand1.count(c) == 4 }
      result -= 1 if uniq2.any? { |c| hand2.count(c) == 4 }
    when 3
      result += 1 if uniq1.any? { |c| hand1.count(c) == 3 }
      result -= 1 if uniq2.any? { |c| hand2.count(c) == 3 }
    end

    i = 0
    while result == 0
      result = strengths.index(hand2[i]) <=> strengths.index(hand1[i])
      i += 1
    end

    result
  end
end.each_with_index.reduce(0) { |sum, ((_, bid), i)| sum + bid * (i + 1) }

puts hands
