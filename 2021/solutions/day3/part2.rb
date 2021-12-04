index = 0
o2gen = []
co2scrub = []

File.foreach("../../inputs/day3.txt") do |bin|
	o2gen << bin
	co2scrub << bin
end

until o2gen.length == 1
	count = {"0" => 0, "1" => 0}

	o2gen.each do |bin|
		count[bin[index]] += 1
	end

	most_common = count["0"] == count["1"] || count["0"] < count["1"] ? "1" : "0"

	o2gen.select! { |bin| bin[index] == most_common }

	index += 1
end

index = 0

until co2scrub.length == 1
	count = {"0" => 0, "1" => 0}

	co2scrub.each do |bin|
		count[bin[index]] += 1
	end

	least_common = count["0"] == count["1"] || count["1"] > count["0"] ? "0" : "1"

	co2scrub.select! { |bin| bin[index] == least_common }

	index += 1
end

puts o2gen[0].to_i(2) * co2scrub[0].to_i(2)
