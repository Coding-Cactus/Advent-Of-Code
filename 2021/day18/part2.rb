nums = []
sums = []
File.foreach("input.txt") do |line|
	calculations = []
	nums.each do |num|
		calculations << "[#{num},#{line.strip}]"
		calculations << "[#{line.strip},#{num}]"
	end
	nums << line.strip

	calculations.each do |sum|
		loop do
			# find first pair inside 4 pairs
			nests = 0
			bracket_index = 0
			sum.split("").each_with_index do |chr, i|
				bracket_index = i
				nests += 1 if chr == "["
				nests -= 1 if chr == "]"
				break if nests == 5 && !["[", ",", "]"].include?(sum[i+1])
			end


			# explode
			if nests > 4
				pair = sum[(bracket_index+1)..-1].split("]")[0]
				left_val, right_val = pair.split(",").map(&:to_i)


				# left numbers
				left_index = right_index = bracket_index-1

				until right_index == 0
					until left_index == 0
						num = sum[left_index..right_index]
						break if num.to_i.to_s == num && ["[", ",", "]"].include?(sum[left_index-1])
						left_index -= 1
					end
					break if num.to_i.to_s == num
					right_index -= 1
					left_index = right_index
				end

				unless right_index == 0
					new_val = (left_val + sum[left_index..right_index].to_i).to_s
					sum[left_index..right_index] = new_val
					bracket_index += new_val.length - (right_index-left_index+1)
				end


				# right numbers
				left_index = right_index = bracket_index+pair.length+2

				until left_index == sum.length-1
					until right_index == sum.length-1
						num = sum[left_index..right_index]
						break if num.to_i.to_s == num && ["[", ",", "]"].include?(sum[right_index+1])
						right_index += 1
					end
					break if num.to_i.to_s == num
					left_index += 1
					right_index = left_index
				end

				unless left_index == sum.length-1
					sum[left_index..right_index] = (right_val + sum[left_index..right_index].to_i).to_s
				end

				# replace pair with 0
				sum[bracket_index..(bracket_index+pair.length+1)] = "0"
				next
			end


			# find first number above 9
			left_index = right_index = nil
			sum.split("").each_index do |left_offset|
				sum.split("")[left_offset..-1].each_index do |right_offset|
					right_index = left_offset + right_offset
					break if ["[", ",", "]"].include?(sum[right_index])
				end
				if right_index - left_offset > 1 # 2+ digit num
					left_index = left_offset
					break
				end
			end

			# split
			if left_index && right_index - left_index > 1
				num = sum[left_index...right_index].to_i
				left_val = num / 2
				right_val = (num / 2.0).ceil

				sum.sub!(num.to_s, "[#{left_val},#{right_val}]")
				next
			end

			break
		end
		sums << sum
	end
end

biggest = 0
sums.each do |sum|
	while sum.include?(",")
		max_nest = 0
		max_nest_index = nil
		nests = 0
		sum.split("").each_with_index do |chr, i|
			nests += 1 if chr == "["
			nests -= 1 if chr == "]"

			if nests > max_nest
				max_nest = nests
				max_nest_index = i
			end
		end

		pair = sum[(max_nest_index+1)..-1].split("]")[0]
		left, right = pair.split(",").map(&:to_i)

		sum[max_nest_index..(max_nest_index+pair.length+1)] = (left*3 + right*2).to_s
	end
	biggest = sum.to_i if sum.to_i > biggest
end

puts biggest
