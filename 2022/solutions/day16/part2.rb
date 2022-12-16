require "set"

flows = {}
connections = {}
File.foreach("../../inputs/day16.txt") do |line|
    valve, cons = line.strip.split("; ")

    v = valve.split[1]
    flows[valve.split[1]] = valve.split("=")[-1].to_i
    connections[v] = cons.split[4..-1].join.split(",")
end

distances = {}
flows.each do |current, _|
    visits = connections.map { |v, _| [v, 9999999999999] }.to_h
    paths = [current]
    visits[current] = 0

    until paths.length == 0
        new_paths = []
        paths.each do |path|
            connections[path].each do |v|
                if visits[path] + 1 < visits[v]
                    new_paths << v
                    visits[v] = visits[path] + 1
                end
            end
        end
        paths = new_paths
    end

    distances[current] = visits
end

distances = distances.map { |c, d| [c, d.reject { |l, _| flows[l] == 0 || c == l }] }.to_h
flows = flows.reject { |_, p| p == 0 }

done = Hash.new(0)
states = [[["AA"], 26, 0]]
until states.length == 0
    new_states = []
    states.each do |seen, mins, total|
        next if seen.length - 1 == flows.length

        done[seen] = [total, done[seen]].max

        current = seen[-1]
        visits = distances[current]

        visits.each do |valve, dist|
            new_min = mins - dist - 1
            if !seen.include?(valve) && new_min >= 0
                t = total + new_min * flows[valve]
                new_states << [seen + [valve], new_min, t]
            end
        end
    end

    states = new_states
end

c = 0
last = 0
total = (done.length ** 2).to_f
max = 0
done.each do |s1, t1|
    done.each do |s2, t2|
        c += 100
        if (c / total).round > last
            last = (c / total).round
            puts "#{(c / total).round}%"
        end

        if t1 + t2 > max && (s1 & s2).length == 1
            max = t1 + t2
        end
    end
end

puts max
