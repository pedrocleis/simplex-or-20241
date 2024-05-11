include("../SimplexOR20241.jl")
using Main.SimplexOR20241

c_test_dual = [1; 2; 3]
c_type_test_dual = -1 # 1 for MAX, -1 for MIN
A_test_dual = [-1   3   0 ;
                2  -1   3;
                0   0   1]
A_type_test_dual = [-1; -1; -1] # 1 for <=, -1 for >=, 0 for =
variable_types_test_dual = [-1, -1, -1] # 1 for <=, -1 for >=, 0 for free
b_test_dual = [5; 6; 4]

c_primal, c_type_primal, A_primal, A_type_primal, b_primal, variable_types_primal=SimplexOR20241.dual_model(c_test_dual, c_type_test_dual, A_test_dual, A_type_test_dual, b_test_dual, variable_types_test_dual)

# ([5, 6, 4], 1, [-1.0 2.0 0.0; 3.0 -1.0 0.0; 0.0 3.0 1.0], [1, 1, 1], [1, 2, 3], [-1, -1, -1])

c_primal = Float64.(reshape(c_primal, :, 1))
A_primal = Float64.(A_primal)
b_primal = Float64.(reshape(b_primal, :, 1))

SimplexOR20241.simplex_method(c_primal, c_type_primal, A_primal, A_type_primal, b_primal)

# x1 = 1 | dual = 0
# x3 = 3 | dual = 2
# x4 = 2 | dual = 4
# A matrix
#  -1.00   2.00   0.00   1.00   0.00   0.00 
#   3.00  -1.00   0.00   0.00   1.00   0.00 
#   0.00   3.00   1.00   0.00   0.00   1.00 
# B
#  -1.00   0.00   1.00 
#   3.00   0.00   0.00 
#   0.00   1.00   0.00 
# Sensitivity Matrix
#  -1.67    Inf 
#  -2.00    Inf 
#  -3.00    Inf 
# Variable Sensitivity
# x1: [2.333333, Inf]
# x3: [5.000000, Inf]
# x4: [4.666667, Inf]
# Optimal value: 15.333333333333332