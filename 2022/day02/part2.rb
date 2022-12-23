score    = 0
scores   = { "A" => 1, "B" => 2, "C" => 3 }
winners  = { "A" => "C", "B" => "A", "C" => "B" }

File.foreach("input.txt") do |line|
    opponent, state = line.split

    case state
    when "X" # lose
        score += scores[winners[opponent]]
    when "Y" # draw
        score += 3 + scores[opponent]
    when "Z" # win
        score += 6 + scores[winners.key(opponent)]
    end
end

puts score
