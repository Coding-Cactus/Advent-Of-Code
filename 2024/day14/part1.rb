def solve(lines)
  width = 101
  height = 103
  mid_x = width / 2
  mid_y = height / 2

  quadrants = [0, 0, 0, 0]
  lines.each do |line|
    x, y, dx, dy = line.scan(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/).first.map(&:to_i)

    x = (x + 100*dx) % width
    y = (y + 100*dy) % height

    quadrants[0] += 1 if x < mid_x && y < mid_y
    quadrants[1] += 1 if x > mid_x && y < mid_y
    quadrants[2] += 1 if x < mid_x && y > mid_y
    quadrants[3] += 1 if x > mid_x && y > mid_y
  end

  quadrants.reduce(:*)
end
