counts = Array.new(12) { {"0" => 0, "1" => 0} }

File.foreach("../../inputs/day3.txt") do |bin|
	bin.strip.split("").each_with_index { |n, index| counts[index][n] += 1 }
end

gamma = counts.map { |bits| bits["0"] > bits ["1"] ? "0" : "1" }.join
epsilon = counts.map { |bits| bits["0"] < bits["1"] ? "0" : "1" }.join

puts gamma.to_i(2) * epsilon.to_i(2)
