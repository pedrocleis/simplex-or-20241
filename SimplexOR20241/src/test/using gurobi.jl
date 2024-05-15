using JuMP, Gurobi
m = Model(Gurobi.Optimizer)

c = [1; 2; 3]
A = [  -1   3   0;
        2  -1   3;
        0   0   1]
b = [5; 6; 4]

index_x = 1:3
index_constraints = 1:3

@variable(m, x[index_x] >= 0, Int)

@objective(m, Max, sum(c[i] * x[i] for i in index_x))

@constraint(m, constraint[j in index_constraints], sum(A[j, i] * x[i] for i in index_x) <= b[j])

JuMP.optimize!(m)
println("Objective value: ", JuMP.objective_value(m))

for i in index_constraints
    println("x[$i] = ", JuMP.value(x[i]))
end

# Optimize a model with 3 rows, 3 columns and 6 nonzeros
# Model fingerprint: 0x3d948f8f
# Variable types: 0 continuous, 3 integer (0 binary)
# Coefficient statistics:
#   Matrix range     [1e+00, 3e+00]
#   Objective range  [1e+00, 3e+00]
#   Bounds range     [0e+00, 0e+00]
#   RHS range        [4e+00, 6e+00]
# Found heuristic solution: objective 7.0000000
# Presolve removed 1 rows and 0 columns
# Presolve time: 0.00s
# Presolved: 2 rows, 3 columns, 5 nonzeros
# Variable types: 0 continuous, 3 integer (0 binary)
# Found heuristic solution: objective 10.0000000

# Root relaxation: objective 1.100000e+01, 1 iterations, 0.00 seconds (0.00 work units)

#     Nodes    |    Current Node    |     Objective Bounds      |     Work
#  Expl Unexpl |  Obj  Depth IntInf | Incumbent    BestBd   Gap | It/Node Time

# *    0     0               0      11.0000000   11.00000  0.00%     -    0s

# Explored 1 nodes (1 simplex iterations) in 0.00 seconds (0.00 work units)
# Thread count was 8 (of 8 available processors)

# Solution count 3: 11 10 7 

# Optimal solution found (tolerance 1.00e-04)
# Best objective 1.100000000000e+01, best bound 1.100000000000e+01, gap 0.0000%

# User-callback calls 149, time in user-callback 0.00 sec
# Objective value: 11.0

# x[1] = 1.0
# x[2] = 2.0
# x[3] = 2.0