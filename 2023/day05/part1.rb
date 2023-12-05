maps = []
seeds = []

first = true
new_map = false
File.foreach("input.txt") do |line|
  if first
    seeds = line.strip.split(": ")[1].split.map(&:to_i)
    first = false
  elsif line == "\n"
    new_map = true
  elsif new_map
    maps << []
    new_map = false
  else
    dest, src, len = line.strip.split.map(&:to_i)
    maps[-1] << [(src...(src + len)), dest - src]
  end
end


min = 999999999999999
seeds.each do |seed|
  maps.each do |map|
    map.each do |range, modifier|
      if range.include?(seed)
        seed += modifier
        break
      end
    end
  end

  min = [min, seed].min
end

puts min
