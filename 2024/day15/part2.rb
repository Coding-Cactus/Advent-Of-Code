UP    = 0 - 1i
RIGHT = 1 + 0i
DOWN  = 0 + 1i
LEFT  = -1 + 0i

def can_move_box?(x, y, dir, grid)
  return true if grid[y][x] == "."
  return false if grid[y][x] == "#"

  if [RIGHT, LEFT].include?(dir)
    can_move_box?(x + 2 * dir.real, y, dir, grid)
  else
    dy = dir.imag

    coords = [[x, y + dy]]
    coords << [x - 1, y + dy] if grid[y][x] == "]"
    coords << [x + 1, y + dy] if grid[y][x] == "["

    coords.all? { |nx, ny| can_move_box?(nx, ny, dir, grid) }
  end
end

def move_box(x, y, dir, grid)
  return if grid[y][x] == "." || grid[y][x] == "#"

  if [RIGHT, LEFT].include?(dir)
    dx = dir.real

    move_box(x + 2 * dx, y, dir, grid)

    grid[y][x + 2 * dx] = grid[y][x + dx]
    grid[y][x + dx] = grid[y][x]
    grid[y][x] = "."
  else
    dy = dir.imag

    coords = [[x, y + dy]]
    coords << [x - 1, y + dy] if grid[y][x] == "]"
    coords << [x + 1, y + dy] if grid[y][x] == "["

    coords.each { |nx, ny| move_box(nx, ny, dir, grid) }

    coords.each do |nx, ny|
      grid[ny][nx] = grid[y][nx]
      grid[y][nx] = "."
    end
  end
end

def solve(lines)
  moves = { "^" => UP, ">" => RIGHT, "v" => DOWN, "<" => LEFT }

  robot = nil
  grid = []
  instructions = []

  lines.each_with_index do |line, y|
    grid << [] if line.include?("#")
    line.chars.each_with_index do |char, x|
      robot = Complex(x * 2, y) if char == "@"
      grid[-1] += %w([ ]) if char == "O"
      grid[-1] += %w[# #] if char == "#"
      grid[-1] += %w[. .] if char == "." || char == "@"
      instructions << char if %w[^ > v <].include?(char)
    end
  end

  instructions.each do |instruction|
    delta = moves[instruction]

    nc = robot + delta
    x, y = nc.real, nc.imag

    if can_move_box?(x, y, delta, grid)
      move_box(x, y, delta, grid)
      robot = nc
    end
  end

  total = 0
  grid.each_with_index do |line, y|
    line.each_with_index do |char, x|
      total += x + 100*y if char == "["
    end
  end
  total
end
