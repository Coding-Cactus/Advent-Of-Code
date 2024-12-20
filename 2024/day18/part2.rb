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

  lines[1024..].each do |new|
    x, y = new.split(",").map(&:to_i)
    corrupted << Complex(x, y)

    valid = false
    queue = [0 + 0i]
    visited = Set[0 + 0i]
    until queue.empty? do
      new_queue = []
      queue.each do |coord|
        if coord == Complex(MAX_X, MAX_Y)
          valid = true
          break
        end

        DIRECTIONS.each do |dir|
          c = coord + dir
          next if visited.include?(c) || !(c.real.between?(0, MAX_X) && c.imag.between?(0, MAX_Y)) || corrupted.include?(c)
          visited << c
          new_queue << c
        end
      end

      break if valid

      queue = new_queue
    end

    return new unless valid
  end
end
