require "set"

MAX_X = 70
MAX_Y = 70
DIRECTIONS = [1 + 0i, 0 + 1i, -1 + 0i, 0 - 1i]

def solve(lines)
  corrupted = Set[]
  lines[...1024].each do |line|
    x, y = line.split(",").map(&:to_i)
    corrupted << Complex(x, y)
  end

  steps = 0
  queue = [0 + 0i]
  visited = Set[0 + 0i]
  until queue.empty? do
    new_queue = []
    queue.each do |coord|
      return steps if coord == Complex(MAX_X, MAX_Y)

      DIRECTIONS.each do |dir|
        c = coord + dir
        next if visited.include?(c) || !(c.real.between?(0, MAX_X) && c.imag.between?(0, MAX_Y)) || corrupted.include?(c)
        visited << c
        new_queue << c
      end
    end

    steps += 1
    queue = new_queue
  end
end
