# include("../SimplexOR20241.jl")
# using Main.SimplexOR20241

# c = [5; 8]
# c_type = 1 # 1 for MAX, -1 for MIN
# A = [   3 2;
#         1 4;
#         1 1]
# A_types = [-1; -1; 1]; # 1 for <=, -1 for >=, 0 for =
# b = [3; 4; 5]

# c = [1; 1]
# c_type = -1 # 1 for MAX, -1 for MIN
# A = [   2 1;
#         1 7]
# A_types = [-1; -1;]; # 1 for <=, -1 for >=, 0 for =
# b = [4; 7;]

# c = [5; 2; 10;]
# c_type = -1 # 1 for MAX, -1 for MIN
# A = [   1 0 -1;
#         0 1 1]
# A_types = [1; -1;]; # 1 for <=, -1 for >=, 0 for =
# b = [10; 10]

c = [1; 2; 3]
c_type = -1 # 1 for MAX, -1 for MIN
A = [ -2 1 3;
        2 3 4]
A_types = [0; 0]
b = [2; 1]


# c = [0;	    -0.4;	0;	    0;	    0;		0;		0;	    0;		0;		0;      0;      0;      -0.32;	0;	    0;		0;	    -0.6;	0;	    0;		0;	    0;		0;		0;		0;		0;		0;		0;	    0;	    -0.48;	0;	    0;	    10;]
# c_type = -1
# A = [-1     1       1	    0		0		0		0	    0		0		0	    0		0		0	    0	    0		0		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;
# -1.06   0		0		1	    0		0		0	    0		0		0	    0		0		0	    0	    0		0		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;							
# 0	    0		0		0	    -1		-1		-1	    -1		0		0	    0		0		1	    1	    0		0		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;
# 0		0	    0		0	    -1.06	-1.06   -0.96   -0.86	0		0	    0		0		0	    0	    1		0		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;
# 0		0	    0		0	    0		0		0	    0		0		0	    0		0		0	    0	    0		-1		1	    1	    1		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;
# 0		0	    0		0	    0		0		0	    0		0		0	    0		0		0	    0	    0		-0.43	0	    0	    0		1	    0		0		0		0		0		0		0	    0	    0		0	    0		0;
# 0		0	    0		0	    0		0		0	    0		0		0	    0		0		0	    0	    0		0		0	    0	    0		0	    -0.43	-0.43	-0.39	-0.37	0		0		0	    0	    0		0	    1		0;
# 0		0	    0		0	    0		0		0	    0		0		0	    0		0		0	    0	    0		0		0	    0	    0		0	    1		1		1		1		0		0		0	    0	    -1		1	    0		1;
# 1		0	    0		0	    0		0		0	    0		0		0	    0		0		0	    0	    0		0		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;				
# 0		0	    0		0	    1		0		0	    0		-1		0	    0		0		0	    0	    0		0		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;
# 0		0	    0		0	    0		1		0	    0		0		-1	    0		0		0	    0	    0		0		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;
# 0		0	    0		0	    0		0		1	    0		0		0	    -1		0		0	    0	    0		0		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;
# 0		0	    0		0	    0		0		0	    1		0		0	    0		-1		0	    0	    0		0		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0      	0;
# 0		-1	    0		1.4	    0		0		0	    0		0		0	    0		0		0	    0	    0		0		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;
# 0		0	    0		0	    0		0		0	    0		0		0	    0		0		0	    0	    0		1		0	    0	    0		0	    0		0		0		0		0		0		0	    0	    0		0	    0		0;
# 0		0	    0		0	    0		0		0	    0		0		0	    0		0		0	    0	    0		0		0	    0	    0		0	    1		0		0		0		-1		0		0		0	    0		0	    0		0;
# 0		0	    0		0	    0		0		0	    0		0		0	    0		0		0	    0	    0		0		0	    0	    0		0	    0		1		0		0		0	    -1		0		0	    0		0	    0		0;
# 0		0	    0		0	    0		0		0	    0		0		0	    0		0		0	    0	    0		0		0	    0	    0		0	    0		0		1		0		0		0		-1		0	    0	    0		0	    0;
# 0       0		0	    0		0	    0		0		0	    0		0		0	    0		0		0	    0	    0		0		0	    0	    0		0	    0		0		1		0		0		0		-1		0	    0	    0		0; 
# 0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       -1      0       0       0       0       0       0       0       0       0       0       0       1.4     0       0       0;
# 0       0       0       0       0       0       0       0       2.364   2.386   2.408   2.429   0       0       0       0       0       0       -1      0       0       0       0       0       2.191   2.191   2.249   2.279   0       0       0       0;
# 0       0       -1      0       0       0       0       0       0       0       0       0       0       0       0       0.109   0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0;
# 0       0       0       0       0       0       0       0       0       0       0       0       0       -1      0       0       0       0       0       0       0.109   0.108   0.108   0.107   0       0       0       0       0       0       0       0;
# 0.301   0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       -1      0       0       0       0       0       0       0       0       0       0       0       0       0       0;
# 0       0       0       0       0.301   0.313   0.313   0.326   0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       -1      0       0;
# 0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0;
# 0       0       0       0       0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       1       0;]
# A_types = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
# b = [0, 0, 0, 0, 0, 0, 0, 44, 80, 80, 0, 0, 0, 0, 500, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 310, 300]

for i in eachindex(b)
    if b[i] < 0
        A[i, :] = -A[i, :]
        b[i] = -b[i]
        A_types[i] = -A_types[i]
    end
end

dummies = Int64[]
rows, columns = size(A)
A_aux = []
number_aux = 0
lines = []

for i in eachindex(A_types)
    if A_types[i] == -1
        number_aux += 2
        push!(lines, i)
    elseif A_types[i] == 1
        number_aux += 1
    else
        number_aux += 1
        push!(lines, i)
    end
end

if c_type == 1
    obj_c = -1
else
    obj_c = 1
end

c_new = zeros(BigFloat, columns + number_aux)

A_aux = zeros(BigFloat, rows, number_aux)

aux_matrix = 0

artificial_variables = []
variables_tableau = []

for i in eachindex(A_types)
    if A_types[i] == 1
        A_aux[i, i + aux_matrix] = 1
        push!(variables_tableau, columns + i + aux_matrix)
    elseif A_types[i] == -1
        A_aux[i, i + aux_matrix] = -1
        A_aux[i, i + aux_matrix + 1] = 1
        c_new[columns + i + aux_matrix + 1] = obj_c
        push!(artificial_variables, columns + i + aux_matrix + 1)
        push!(variables_tableau, columns + i + aux_matrix + 1)
        aux_matrix += 1
    else
        A_aux[i, i] = 1
        c_new[columns + i] = obj_c
        push!(artificial_variables, columns + i + aux_matrix)
        push!(variables_tableau, columns + i + aux_matrix)
    end
end

new_A = hcat(A, A_aux)

b_value = 0

new_A = vcat(c_new', new_A)
new_b = vcat(-b_value, b)

tableau = hcat(new_A, new_b)

old_objective = vcat(c, zeros(BigFloat, (number_aux)))

while true
    new_A = tableau[2:end, 1:end-1]
    first_line = tableau[1, 1:end-1]
    
    c_z = zeros(BigFloat, length(first_line))

    check = true

    for i in eachindex(c_z)
        aux_sum = 0
        for row in eachindex(variables_tableau)
            aux_sum += new_A[row, i] * first_line[variables_tableau[row]]
        end
        if c_type == 1
            c_z[i] = aux_sum - first_line[i]
        else
            c_z[i] = first_line[i] - aux_sum
        end
    end

    for i in eachindex(c_z)
        if c_z[i] < -1e-6
            check = false
            break
        end
    end

    if check
        break
    end

    min_value, min_index = findmin(c_z)
    rhs = tableau[2:end, end]
    
    min_value_test, min_index_test = findmin(ifelse.(tableau[2:end, min_index] .!= 0, rhs ./ tableau[2:end, min_index], Inf))
    min_index_test += 1
    tableau[min_index_test, :] = tableau[min_index_test, :]./tableau[min_index_test, min_index]
    
    for i in 1:rows + 1
        if i != min_index_test
            tableau[i, :] = tableau[i, :] - tableau[i, min_index] * tableau[min_index_test, :]
        end
    end

    tableau = tableau[:, 1:end .!= variables_tableau[min_index_test - 1]]

    for i in eachindex(variables_tableau)
        if variables_tableau[i] > variables_tableau[min_index_test - 1]
            variables_tableau[i] = variables_tableau[i] - 1
        end
    end
    
    variables_tableau[min_index_test - 1] = min_index
end

tableau

rows_A, columns_A = size(A)
# 1 for <=, -1 for >=, 0 for =

for i in eachindex(variables_tableau)
    if variables_tableau[i] ∈ artificial_variables
        error("Infeasible solution")
    end
end

tableau



old_objective = vcat(c, zeros(BigFloat, (number_aux - length(artificial_variables) + 1)))
tableau[1, :] = old_objective'

while true
    check = true

    new_A = tableau[2:end, 1:end-1]
    first_line = tableau[1, 1:end-1]

    c_z = zeros(BigFloat, length(first_line))

    for i in eachindex(c_z)
        aux_sum = 0
        for row in eachindex(variables_tableau)
            aux_sum += new_A[row, i] * first_line[variables_tableau[row]]
        end
        if c_type == 1
            c_z[i] = aux_sum - old_objective[i]
        else
            c_z[i] = old_objective[i] - aux_sum
        end
    end

    for i in eachindex(c_z)
        if c_z[i] < -1e-6
            check = false
            break
        end
    end

    if check
        break
    end

    min_value, min_index = findmin(c_z)

    rhs = tableau[2:end, end] 
    filtered_values_with_indices = filter(x -> x[1] > 0, collect(enumerate(ifelse.(tableau[2:end, min_index] .!= 0, rhs ./ tableau[2:end, min_index], Inf))))
    filtered_values = filter(x -> x[2] > 0, filtered_values_with_indices)
    (min_index_test, min_value_test), useless = findmin(filtered_values)
    min_index_test += 1
    tableau[min_index_test, :] = tableau[min_index_test, :]./tableau[min_index_test, min_index]

    for i in 1:rows + 1
        if i != min_index_test
            tableau[i, :] = tableau[i, :] - tableau[i, min_index] * tableau[min_index_test, :]
        end
    end

    variables_tableau[min_index_test - 1] = min_index
end

variables_tableau

objective_sum = 0

for i in eachindex(c)
    if i ∉ variables_tableau
        println("x", i, " = 0")
    else
        index_variable = tableau[i + 1, variables_tableau[i]]
        value_variable = tableau[i + 1, end]
        println("x", variables_tableau[i], " = ", value_variable)
        objective_sum += value_variable * c[variables_tableau[i]]
    end
end

println("Objective Function: ", objective_sum)