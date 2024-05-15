using JuMP, Gurobi
m = Model(Gurobi.Optimizer)

c = [19; 13; 12; 17;]
A = [   3 2 1 2 ;
        1 1 1 1 ;
        4 3 3 4 ]
b = [225; 117; 420]

index_x = 1:4
index_constraints = 1:3

@variable(m, x[index_x] >= 0, Int)

@objective(m, Max, sum(c[i] * x[i] for i in index_x))

@constraint(m, constraint[j in index_constraints], sum(A[j, i] * x[i] for i in index_x) <= b[j])

JuMP.optimize!(m)
println("Objective value: ", JuMP.objective_value(m))

for i in index_constraints
    println("x[$i] = ", JuMP.value(x[i]))
end

# Optimize a model with 3 rows, 4 columns and 12 nonzeros
# Model fingerprint: 0xd87dcf6f
# Variable types: 0 continuous, 4 integer (0 binary)
# Coefficient statistics:
#   Matrix range     [1e+00, 4e+00]
#   Objective range  [1e+01, 2e+01]
#   Bounds range     [0e+00, 0e+00]
#   RHS range        [1e+02, 4e+02]
# Found heuristic solution: objective 1425.0000000
# Presolve time: 0.00s
# Presolved: 3 rows, 4 columns, 12 nonzeros
# Variable types: 0 continuous, 4 integer (0 binary)

# Root relaxation: objective 1.827000e+03, 3 iterations, 0.00 seconds (0.00 work units)

#     Nodes    |    Current Node    |     Objective Bounds      |     Work
#  Expl Unexpl |  Obj  Depth IntInf | Incumbent    BestBd   Gap | It/Node Time

# *    0     0               0    1827.0000000 1827.00000  0.00%     -    0s

# Explored 1 nodes (3 simplex iterations) in 0.00 seconds (0.00 work units)
# Thread count was 8 (of 8 available processors)

# Solution count 2: 1827 1425 

# Optimal solution found (tolerance 1.00e-04)
# Best objective 1.827000000000e+03, best bound 1.827000000000e+03, gap 0.0000%

# User-callback calls 146, time in user-callback 0.00 sec
# Objective value: 1827.

# x[1] = 39.0
# x[2] = -0.0
# x[3] = 48.0