require "set"

def solve(lines)
  width = 101
  height = 103

  robots = []
  lines.each do |line|
    robots << line.scan(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/).first.map(&:to_i)
  end

  i = 0
  loop do
    coords = Set[]

    robots.each_with_index do |(x, y, dx, dy), i|
      coords << Complex(x, y)

      robots[i][0] = (x + dx) % width
      robots[i][1] = (y + dy) % height
    end

    if coords.any? { |coord| (1...10).all? { |dx| coords.include?(coord + dx) } }
      puts "After #{i} seconds:"

      grid = Array.new(height) { Array.new(width) { " " } }
      coords.each { |coord| grid[coord.imag][coord.real] = "#" }
      puts grid.map { |row| row.join(" ") }

      puts "Press enter to find the next one.."
      gets
    end

    i += 1
  end
end
