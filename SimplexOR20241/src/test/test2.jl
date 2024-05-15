include("../SimplexOR20241.jl")
using Main.SimplexOR20241

c = [19; 13; 12; 17;]
c_type = 1 # 1 for MAX, -1 for MIN
A = [   3 2 1 2 ;
        1 1 1 1 ;
        4 3 3 4 ]
A_type = [1; 1; 1] # 1 for <=, -1 for >=, 0 for =
b = [225; 117; 420]
variable_type = [-1, -1, -1, -1]

c = Array{BigFloat}(c)
A = Array{BigFloat}(A)
b = Array{BigFloat}(b)

SimplexOR20241.simplex_method(c, c_type, A, A_type, b)

# x1 = 39 | dual = 2
# x3 = 48 | dual = 1
# x4 = 30 | dual = 3
# A matrix
#   3.00   2.00   1.00   2.00   1.00   0.00   0.00 
#   1.00   1.00   1.00   1.00   0.00   1.00   0.00 
#   4.00   3.00   3.00   4.00   0.00   0.00   1.00 
# B
#   3.00   1.00   2.00 
#   1.00   1.00   1.00 
#   4.00   3.00   4.00 
# Sensitivity Matrix
# -39.00  30.00 
# -12.00   6.00 
# -15.00  39.00 
# Variable Sensitivity
# x1: [78.000000, 69.000000]
# x3: [60.000000, 54.000000]
# x4: [45.000000, 69.000000]
# Optimal value: 1827.0