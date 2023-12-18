def solve(lines)
  directions = { "R" => [1, 0], "D" => [0, 1], "L" => [-1, 0], "U" => [0, -1] }

  coord = [0, 0]
  corners = []
  num_edges = 0
  previous_coord = [0, 0]

  # calculate area inside edge using shoelace formula
  inner_area = lines.reduce(0) do |s, line|
    dir, len, _ = line.split
    len = len.to_i
    dx, dy = directions[dir]

    num_edges += len
    coord = [coord[0] + dx * len, coord[1] + dy * len]
    corners << coord

    determinant = coord[0] * previous_coord[1] - coord[1] * previous_coord[0]
    previous_coord = coord

    s + determinant / 2.0 # shoelace formula
  end.to_i.abs

  inner_area + num_edges / 2 + 1
end
