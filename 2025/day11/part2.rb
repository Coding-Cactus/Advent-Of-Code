def solve(lines)
  graph = lines.map { |l| [l.split(":")[0], l.split(":")[1].split] }.to_h

  paths = 0
  seen_neither = { "svr" => 1 }
  seen_dac = {}
  seen_fft = {}
  seen_both = {}
  until seen_neither.empty? && seen_dac.empty? && seen_fft.empty? && seen_both.empty?
    new_seen_neither = Hash.new(0)
    new_seen_dac = Hash.new(0)
    new_seen_fft = Hash.new(0)
    new_seen_both = Hash.new(0)

    seen_neither.each do |k, v|
      next if k == "out"

      next_collection = new_seen_neither
      next_collection = new_seen_dac if k == "dac"
      next_collection = new_seen_fft if k == "fft"
      graph[k].each { |n| next_collection[n] += v }
    end
    seen_dac.each do |k, v|
      next if k == "out"

      next_collection = new_seen_dac
      next_collection = seen_both if k == "fft"
      graph[k].each { |n| next_collection[n] += v }
    end
    seen_fft.each do |k, v|
      next if k == "out"

      next_collection = new_seen_fft
      next_collection = seen_both if k == "dac"
      graph[k].each { |n| next_collection[n] += v }
    end
    seen_both.each do |k, v|
      if k == "out"
        paths += v
        next
      end

      graph[k].each { |n| new_seen_both[n] += v }
    end

    seen_neither = new_seen_neither
    seen_dac = new_seen_dac
    seen_fft = new_seen_fft
    seen_both = new_seen_both
  end
  paths
end
