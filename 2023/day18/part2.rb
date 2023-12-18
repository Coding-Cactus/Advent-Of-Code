def solve(lines)
  directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  coord = [0, 0]
  corners = []
  num_edges = 0
  previous_coord = [0, 0]

  # calculate area inside edge using shoelace formula
  inner_area = lines.reduce(0) do |s, line|
    _, _, hex = line.gsub(/[(#)]/, "").split
    len = hex[...-1].to_i(16)
    dx, dy = directions[hex[-1].to_i]

    num_edges += len
    coord = [coord[0] + dx * len, coord[1] + dy * len]
    corners << coord

    determinant = coord[0] * previous_coord[1] - coord[1] * previous_coord[0]
    previous_coord = coord

    s + determinant / 2.0 # shoelace formula
  end.to_i.abs

  inner_area + num_edges / 2 + 1
end
