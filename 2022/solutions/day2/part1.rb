score    = 0
scores   = { "A" => 1, "B" => 2, "C" => 3 }
winners  = { "A" => "C", "B" => "A", "C" => "B" }

File.foreach("../../inputs/day2.txt") do |line|
  opponent, suggested = line.split

  suggested = (suggested.ord - 23).chr

  s = scores[suggested]
  
  if winners[suggested] == opponent # win
    score += s + 6
  elsif opponent == suggested # draw
    score += s + 3
  else # lose
    score += s
  end
end

puts score
