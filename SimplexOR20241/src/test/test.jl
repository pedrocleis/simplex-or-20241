include("../SimplexOR20241.jl")
using Main.SimplexOR20241

c = [1; 2; 3]
c_type = 1 # 1 for MAX, -1 for MIN
A = [  -1   3   0;
        2  -1   3;
        0   0   1]
A_type = [1; 1; 1] # 1 for <=, -1 for >=, 0 for =
b = [5; 6; 4]
variable_type = [-1, -1, -1, -1] # 1 for <=, -1 for >=, 0 for =

c = Array{BigFloat}(c)
A = Array{BigFloat}(A)
b = Array{BigFloat}(b)

SimplexOR20241.simplex_method(c, c_type, A, A_type, b)

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
