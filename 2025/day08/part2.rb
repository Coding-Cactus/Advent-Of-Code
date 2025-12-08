def square_dist(u, v) = (v[0]-u[0])**2 + (v[1]-u[1])**2 + (v[2]-u[2])**2

def solve(lines)
  num_vertices = lines.length
  groups = []
  in_group = {}
  lines.map { |l| l.split(",").map(&:to_i) }.combination(2).sort_by { |u, v| square_dist(u, v) }.each do |u, v|
    if in_group.include?(u)
      u_group, v_group = in_group[u], in_group[v]
      next if u_group == v_group

      group = groups[u_group]
      if v_group.nil?
        group << v
        in_group[v] = u_group
      else
        groups[v_group].each { |x| group << x; in_group[x] = u_group }
      end
    elsif in_group.include?(v)
      groups[in_group[v]] << u
      in_group[u] = in_group[v]
    else
      groups << [u, v]
      in_group[u] = groups.length-1
      in_group[v] = groups.length-1
    end

    return u[0] * v[0] if groups.any? { |g| g.length == num_vertices }
  end
end
