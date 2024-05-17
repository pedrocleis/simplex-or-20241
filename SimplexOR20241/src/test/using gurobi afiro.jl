using JuMP, Gurobi
m = Model(Gurobi.Optimizer)
lp = read_from_file(pwd() * "/SimplexOR20241/src/test/afiro.mps")

MOI.copy_to(backend(m), lp)

JuMP.optimize!(m)



using JuMP, Gurobi
m = Model(Gurobi.Optimizer)
lp = read_from_file(pwd() * "/SimplexOR20241/src/test/afiro.lp")

MOI.copy_to(backend(m), lp)

JuMP.optimize!(m)
