require "z3"

def solve(lines)
  solver = Z3::Solver.new

  lines[...3].each_with_index do |line, i|
    pos, vel = line.split(" @ ")
    xn, yn, zn    = pos.split(", ").map(&:to_i)
    vxn, vyn, vzn = vel.split(", ").map(&:to_i)

    solver.assert(Z3.Int("x") + Z3.Int("vx") * Z3.Int("t#{i}") == xn + vxn * Z3.Int("t#{i}"))
    solver.assert(Z3.Int("y") + Z3.Int("vy") * Z3.Int("t#{i}") == yn + vyn * Z3.Int("t#{i}"))
    solver.assert(Z3.Int("z") + Z3.Int("vz") * Z3.Int("t#{i}") == zn + vzn * Z3.Int("t#{i}"))
  end

  if solver.satisfiable?
    model = solver.model
    model[Z3.Int("x")].to_i + model[Z3.Int("y")].to_i + model[Z3.Int("z")].to_i
  else
    "Didn't work :("
  end
end
