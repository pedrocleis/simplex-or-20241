include("../SimplexOR20241.jl")
using Main.SimplexOR20241

c_test_dual = [1; 2; 3]
c_type_test_dual = 1 # 1 for MAX, -1 for MIN
A_test_dual = [-1   3   0 ;
                2  -1   3;
                0   0   1]
A_type_test_dual = [1; 1; 1] # 1 for <=, -1 for >=, 0 for =
variable_types_test_dual = [-1, -1, -1] # 1 for <=, -1 for >=, 0 for free
b_test_dual = [5; 6; 4]

c_test_dual = Array{Float64}(c_test_dual)
A_test_dual = Array{Float64}(A_test_dual)
b_test_dual = Array{Float64}(b_test_dual)

SimplexOR20241.simplex_method(c_test_dual, c_type_test_dual, A_test_dual, A_type_test_dual, b_test_dual)

# x1 = 5 | dual = 1
# x2 = 3 | dual = 1
# x6 = 4 | dual = 0
# A matrix
#  -1.00   3.00   0.00   1.00   0.00   0.00 
#   2.00  -1.00   3.00   0.00   1.00   0.00 
#   0.00   0.00   1.00   0.00   0.00   1.00 
# B
#  -1.00   3.00   0.00 
#   2.00  -1.00   0.00 
#   0.00   0.00   1.00 
# Sensitivity Matrix
#  -8.00    Inf 
#  -7.67    Inf 
#  -4.00    Inf 
# Variable Sensitivity
# x1: [12.600000, Inf]
# x2: [10.866667, Inf]
# x6: [8.000000, Inf]
# Optimal value: 11.0