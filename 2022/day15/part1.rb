require "set"

LINE = 2000000
beacons_on_line = []
sensors = []
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
    beacons_on_line << beacon[0] if beacon[1] == LINE

    d = (sensor[0] - beacon[0]).abs + (sensor[1] - beacon[1]).abs - (sensor[1] - LINE).abs
    sensors << [sensor[0], d] if d > 0
end

points = Set[]
sensors.each do |x, dist|
    dist.downto(0) do |dx|
        points << x + dx unless beacons_on_line.include?(x + dx)
        points << x - dx unless beacons_on_line.include?(x - dx)
    end
end

puts points.length
