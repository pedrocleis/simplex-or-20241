using JuMP, Gurobi
m = Model(Gurobi.Optimizer)

c = [1; 2; 3]
A = [-1   3   0 ;
    2  -1   3;
    0   0   1]
b = [5; 6; 4]

index_x = 1:3
index_constraints = 1:3

@variable(m, x[index_x] >= 0)

@objective(m, Max, sum(c[i] * x[i] for i in index_x))

@constraint(m, constraint[j in index_constraints], sum(A[j, i] * x[i] for i in index_x) <= b[j])

JuMP.optimize!(m)
println("Objective value: ", JuMP.objective_value(m))

# Optimize a model with 3 rows, 3 columns and 6 nonzeros
# Model fingerprint: 0x002c71c8
# Coefficient statistics:
#   Matrix range     [1e+00, 3e+00]
#   Objective range  [1e+00, 3e+00]
#   Bounds range     [0e+00, 0e+00]
#   RHS range        [4e+00, 6e+00]
# Presolve removed 3 rows and 3 columns
# Presolve time: 0.00s
# Presolve: All rows and columns removed
# Iteration    Objective       Primal Inf.    Dual Inf.      Time
#        0    1.1000000e+01   0.000000e+00   0.000000e+00      0s

# Solved in 0 iterations and 0.00 seconds (0.00 work units)
# Optimal objective  1.100000000e+01

# User-callback calls 48, time in user-callback 0.00 sec
# Objective value: 11.0

for i in index_constraints
    println("x[$i] = ", JuMP.value(x[i]))
end

# x[1] = 0.0
# x[2] = 1.6666666666666667
# x[3] = 2.5555555555555554


for j in index_constraints
    println("dual[$j] = ", JuMP.shadow_price(constraint[j]))
end

# dual[1] = 1.0
# dual[2] = 1.0
# dual[3] = 0.0