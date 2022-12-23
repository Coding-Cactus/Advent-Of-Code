require "set"

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

enclosed = Set[]
not_enclosed = Set[]

min = cubes.reduce(9999) { |m, (x, y, z)| [m, x, y, z].min }
max = cubes.reduce(0)    { |m, (x, y, z)| [m, x, y, z].max }

r = min..max
r.each do |x|
    r.each do |y|
        r.each do |z|
            cube = [x, y, z]

            next if cubes.include?(cube)

            if (min...x).any?        { |_x| cubes.include?([_x, y, z]) } &&
                ((x + 1)..max).any?  { |_x| cubes.include?([_x, y, z]) } &&
                (min...y).any?       { |_y| cubes.include?([x, _y, z]) } &&
                ((y + 1)..max).any?  { |_y| cubes.include?([x, _y, z]) } &&
                (min...z).any?       { |_z| cubes.include?([x, y, _z]) } &&
                ((z + 1)..max).any?  { |_z| cubes.include?([x, y, _z]) }

                enclosed << cube
            else
                not_enclosed << cube
            end
        end
    end
end

done = false
until done
    s = enclosed.length

    enclosed.each do |cube|
        neighbours(cube).each do |n|
            if not_enclosed.include?(n)
                not_enclosed << cube
                enclosed.delete(cube)
                break
            end
        end
    end

    done = s == enclosed.length
end

puts(
    cubes.reduce(0) do |sa, cube|
        sa + neighbours(cube).reduce(0) do |s, n|
            cubes.include?(n) || enclosed.include?(n) ? s : s + 1
        end
    end
)
