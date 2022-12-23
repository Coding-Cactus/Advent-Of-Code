require "set"

sensors = {}
File.foreach("input.txt") do |line|
    sensor, beacon = line.strip.split(": ")

    sensor = [
        sensor.split(", ")[0].split[-1].split("=")[-1].to_i,
        sensor.split(", ")[1].split[-1].split("=")[-1].to_i
    ]

    beacon = [
        beacon.split(", ")[0].split[-1].split("=")[-1].to_i,
        beacon.split(", ")[1].split[-1].split("=")[-1].to_i
    ]

    sensors[sensor] = (sensor[0] - beacon[0]).abs + (sensor[1] - beacon[1]).abs
end

done = false
LIMIT = 4_000_000
(0..LIMIT).each do |y1|
    c = Hash.new(0)
    sensors.each do |(x2, y2), d|
        r = d - (y1-y2).abs + x2
        l = (y1-y2).abs - d + x2

        if l < r
            c[l - 1] += 1
            c[r + 1] -= 1
        end
    end

    c.each do |x1, count|
        if count == 0 and x1.between?(0, LIMIT) && sensors.all? { |(x3, y3), d2| (y1 - y3).abs + (x1 - x3).abs > d2 }
            puts x1 * 4_000_000 + y1
            done = true
            break
        end
    end
    break if done
end
