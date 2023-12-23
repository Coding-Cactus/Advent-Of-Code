require "set"

def solve(lines)
  grid = []
  start_x = nil

  lines.each do |line|
    start_x = line.index(".") if start_x.nil?
    grid << line.gsub(/[>v<]/, ".").chars
  end

  directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  connected_junctions = Hash.new { |h, k| h[k] = [] }

  grid.each_with_index do |row, junc_y|
    row.each_index do |junc_x|
      next unless grid[junc_y][junc_x] == "."

      paths = directions.reduce(0) do |c, (dx, dy)|
        nx, ny = junc_x + dx, junc_y + dy
        c + (nx.between?(0, grid[0].length - 1) && ny.between?(0, grid.length - 1) && grid[ny][nx] == "." ? 1 : 0)
      end

      next unless paths > 2 || junc_y == 0

      junc_coord = [junc_x, junc_y]
      paths = [[junc_x, junc_y, Set[junc_coord]]]
      found_junctions = Hash.new(0)
      until paths.empty?
        x, y, seen = paths.pop

        directions.each do |dx, dy|
          nx, ny = x + dx, y + dy

          next unless nx.between?(0, grid[0].length - 1) && ny.between?(0, grid.length - 1) && grid[ny][nx] == "." && !seen.include?([nx, ny])

          surrounding_paths = directions.reduce(0) do |c, (_dx, _dy)|
            _nx, _ny = nx + _dx, ny + _dy
            c + (_nx.between?(0, grid[0].length - 1) && _ny.between?(0, grid.length - 1) && grid[_ny][_nx] == "." ? 1 : 0)
          end

          coord = [nx, ny]
          if surrounding_paths > 2 || ny == grid.length - 1
            found_junctions[coord] = [seen.length, found_junctions[coord]].max
          else
            paths << [nx, ny, seen + [coord]]
          end
        end
      end

      # hash of strings is faster than hash of arrays
      found_junctions.each { |coord, len| connected_junctions[junc_coord.join(",")] << [coord.join(","), len] }
    end
  end

  grid_len_str = (grid.length - 1).to_s

  max = 0
  junctions = [["#{start_x},0", 0, Set["#{start_x},0"]]]
  until junctions.empty?
    coord, path_len, seen = junctions.pop

    connected_junctions[coord].each do |n_coord, len|
      next if seen.include?(n_coord)

      if n_coord[-grid_len_str.length..-1] == grid_len_str
        max = [max, path_len + len].max
        break
      end

      junctions << [n_coord, path_len + len, seen + [n_coord]]
    end
  end

  max
end
