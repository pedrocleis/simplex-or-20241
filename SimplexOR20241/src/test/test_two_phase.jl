include("../SimplexOR20241.jl")
using Main.SimplexOR20241

c = [1; 1]
c_type = -1 # 1 for MAX, -1 for MIN
A = [   2 1;
        1 7]
A_types = [-1; -1;] # 1 for <=, -1 for >=, 0 for =
b = [4; 7;]

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

c_new = zeros(BigFloat, columns + number_aux)

A_aux = zeros(BigFloat, rows, number_aux)

aux_matrix = 0

artificial_variables = []
variables_tableau = []

for i in eachindex(A_types)
    if A_types[i] == 1
        A_aux[i, i + aux_matrix] = 1
        push!(variables_tableau, columns + i)
    elseif A_types[i] == -1
        A_aux[i, i + aux_matrix] = -1
        A_aux[i, i + aux_matrix + 1] = 1
        c_new[columns + i + aux_matrix + 1] = 1
        push!(artificial_variables, columns + i + aux_matrix + 1)
        push!(variables_tableau, columns + i + aux_matrix + 1)
        aux_matrix += 1
    else
        A_aux[i, i] = 1
        c_new[columns + i] = 1
        push!(artificial_variables, columns + i + aux_matrix)
        push!(variables_tableau, columns + i + aux_matrix)
        
    end
end

A = hcat(A, A_aux)

z = zeros(BigFloat, length(c_new))

b_value = 0

for i in eachindex(lines)
    z = z + -1*A[lines[i], :]
    b_value += b[lines[i]]
end

for i in eachindex(artificial_variables)
    z[artificial_variables[i]] = 0
end

A = vcat(z', A)
b = vcat(-b_value, b)

tableau = hcat(A, b)

while true
    first_line = tableau[1, 1:end-1]
    
    check = true
    for i in eachindex(first_line)
        if i ∉ artificial_variables && (first_line[i] <= -1e-6 || first_line[i] >= 1e-6)
            check = false
        end
    end

    if check
        break
    end

    min_value, min_index = findmin(first_line)
    rhs = tableau[2:end, end]
    
    min_value_test, min_index_test = findmin(ifelse.(tableau[2:end, min_index] .!= 0, rhs ./ tableau[2:end, min_index], Inf))
    min_index_test += 1
    tableau[min_index_test, :] = tableau[min_index_test, :]./tableau[min_index_test, min_index]
    
    for i in 1:rows + 1
        if i != min_index_test
            tableau[i, :] = tableau[i, :] - tableau[i, min_index] * tableau[min_index_test, :]
        end
    end
    
    variables_tableau[min_index_test - 1] = min_index
end

for i in eachindex(artificial_variables)
    tableau = tableau[:, 1:end .!= artificial_variables[i]]
end


old_objective = vcat(c, zeros(BigFloat, (number_aux - length(artificial_variables) + 1)))
tableau[1, :] = old_objective'
tableau