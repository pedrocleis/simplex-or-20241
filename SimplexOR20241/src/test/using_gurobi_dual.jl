using JuMP, Gurobi
m = Model(Gurobi.Optimizer)

c = [5; 6; 4]
A = [  -1.0  2.0 0.0;
        3.0 -1.0 0.0;
        0.0  3.0 1.0]
b = [1, 2, 3]

index_x = 1:3
index_constraints = 1:3

@variable(m, x[index_x] >= 0)

@objective(m, Max, sum(c[i] * x[i] for i in index_x))

@constraint(m, constraint[j in index_constraints], sum(A[j, i] * x[i] for i in index_x) <= b[j])

JuMP.optimize!(m)
println("Objective value: ", JuMP.objective_value(m))

# Optimize a model with 3 rows, 3 columns and 6 nonzeros
# Model fingerprint: 0xcbb6ece6
# Coefficient statistics:
#   Matrix range     [1e+00, 3e+00]
#   Objective range  [4e+00, 6e+00]
#   Bounds range     [0e+00, 0e+00]
#   RHS range        [1e+00, 3e+00]
# Presolve removed 3 rows and 3 columns
# Presolve time: 0.00s
# Presolve: All rows and columns removed
# Iteration    Objective       Primal Inf.    Dual Inf.      Time
#        0    1.5333333e+01   0.000000e+00   0.000000e+00      0s

# Solved in 0 iterations and 0.00 seconds (0.00 work units)
# Optimal objective  1.533333333e+01

# User-callback calls 47, time in user-callback 0.00 sec
# Objective value: 15.333333333333332

for i in index_constraints
    println("x[$i] = ", JuMP.value(x[i]))
end

# x[1] = 0.6666666666666666
# x[2] = 0.0
# x[3] = 3.0


for j in index_constraints
    println("dual[$j] = ", JuMP.shadow_price(constraint[j]))
end

# dual[1] = 0.0
# dual[2] = 1.6666666666666667
# dual[3] = 4.0