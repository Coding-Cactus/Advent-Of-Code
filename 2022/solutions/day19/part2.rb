require "set"

blueprints = []
File.foreach("../../inputs/day19.txt") do |line|
    blueprints << line.split(": ")[1].split(". ").map do |r|
        [
            r.split(" robot")[0].split("Each ")[1].to_sym,
            r.split("costs ")[1].split(" and ").map do |c|
                [c.split[1].sub(".", "").to_sym, c.split[0].to_i]
            end.to_h
        ]
    end.to_h
end

blueprints = blueprints[0...3]

maxes = Array.new(blueprints.length) { 0 }
TIME = 32
blueprints.each_with_index do |bp, i|
    states = [{ resources: Hash.new(0), robots: { ore: 1, clay: 0, obsidian: 0, geode: 0 }, time: 0 }]
    until states.length == 0
        new_states = Set[]
        states.each do |state|
            # Options:
            # 1. Don't buy any bots for the rest of the time
            # 2. wait to buy geode bot
            # 3. wait to buy obsidian bot
            # 4. wait to buy clay bot
            # 5. wait to buy ore bot

            # 1:
            maxes[i] = [maxes[i], state[:resources][:geode] + state[:robots][:geode] * (TIME - state[:time])].max

            # 2, 3, 4, 5:
            bp.each do |bot_type, cost|
                next if cost.any? { |t, _| state[:robots][t] == 0 } || (bot_type != :geode &&
                    bp.all? { |_, prices| prices[bot_type].nil? || state[:robots][bot_type] >= prices[bot_type] })

                mins = 1
                s = Marshal.load(Marshal.dump(state))
                until cost.all? { |type, price| s[:resources][type] >= price }
                    mins += 1
                    s[:robots].each { |bt, count| s[:resources][bt] += count }
                end
                s[:time] += mins
                cost.each { |type, price| s[:resources][type] -= price }

                s[:robots].each { |bt, count| s[:resources][bt] += count }
                s[:robots][bot_type] += 1

                time_left = TIME - s[:time]

                new_states << s if time_left >= 0 &&
                    maxes[i] < time_left *
                        (s[:resources][:geode] + (s[:robots][:geode] + 0.5 * time_left * (time_left + 1)))
            end
        end
        states = new_states
    end
end

puts maxes.reduce(1) { |p, n| p * n }
