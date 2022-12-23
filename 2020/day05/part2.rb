seat_ids = []
File.foreach("input.txt") do |line|
	row = line.strip[0...7].split("")
	col = line.strip[7..-1].split("")

	row = row.reduce((0..127).to_a) do |rows, chr|
		chr == "F" ? rows[0...(rows.length/2)] : rows[(rows.length/2)..-1]
	end

	col = col.reduce((0..8).to_a) do |cols, chr|
		chr == "L" ? cols[0...(cols.length/2)] : cols[(cols.length/2)..-1]
	end

	seat_ids << row[0] * 8 + col[0]
end

seat_ids.each do |id|
	if !seat_ids.include?(id+1) && seat_ids.include?(id+2)
		puts id+1
		break
	end
end
