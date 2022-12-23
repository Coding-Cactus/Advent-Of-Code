cubes = []
File.foreach("input.txt") { |line| cubes << line.strip.split(",").map(&:to_i) }

def neighbours(cube)
    [
        [cube[0], cube[1], cube[2] + 1],
        [cube[0], cube[1], cube[2] - 1],
        [cube[0], cube[1] + 1, cube[2]],
        [cube[0], cube[1] - 1, cube[2]],
        [cube[0] + 1, cube[1], cube[2]],
        [cube[0] - 1, cube[1], cube[2]]
    ]
end

puts cubes.reduce(0) { |sa, cube| sa + (neighbours(cube) | cubes).length - cubes.length }
