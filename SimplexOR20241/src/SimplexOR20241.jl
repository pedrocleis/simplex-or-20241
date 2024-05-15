module SimplexOR20241
    using LinearAlgebra, Combinatorics, Printf

    export simplex_method, dual_model

    function simplex_method(c, c_type, A, A_types, b)
        b_indices, x_values_B, B, A, c, dummies = initialize(c, c_type, A, A_types, b)

        dual_variables = dual_variables_function(c, B, b_indices)'

        pricing = pricing_function(c, dual_variables, A, b_indices)
        
        while any(pricing .> 1e-6)
            indices = findall(x -> x > 0, pricing)
            entering_index = rand(indices)
            d = B \ A[:, entering_index]
            if all(d .<= 1e-6)
                error("Unbounded")
            end
            leaving_index = argmin([x_values_B[i] / d[i] for i in 1:length(d) if d[i] > 1e-6])
            b_indices[leaving_index] = entering_index
            B = A[:, b_indices]
            x_values_B = round.(Int64, inv(B) * b, RoundNearest)
            dual_variables = dual_variables_function(c, B, b_indices)'
            pricing = pricing_function(c, dual_variables, A, b_indices)
        end

        print_variables_values_and_duals(x_values_B, b_indices, dual_variables)
        print_matrix("A matrix", A)
        print_matrix("B", B)
        # println("c", c)
        # println("dual_variables ", dual_variables)
        optimal_value = 0

        variable_sensitivity(inv(B'), x_values_B, b_indices)

        for i in eachindex(b_indices)
            optimal_value += c[b_indices[i]] * x_values_B[i]
        end
        println("Optimal value: ", optimal_value)
    end

    function variable_sensitivity(s_estrela, b_estrela, b_indices)
        rows, columns = size(s_estrela)
        sensitivity = Matrix{BigFloat}(undef, rows, 2)
        sensitivity[:, 1] .= typemin(BigFloat)
        sensitivity[:, 2] .= typemax(BigFloat)
        for i in eachindex(b_indices)
            s_estrela_i = s_estrela[i, :]
            for j in eachindex(s_estrela_i)
                if s_estrela_i[j] != 0
                    if s_estrela_i[j] > 0
                        aux = (-b_estrela[j]) / s_estrela_i[j]
                        if aux  > sensitivity[i, 1]
                            sensitivity[i, 1] = aux
                        end
                    else
                        aux = (-b_estrela[j]) / s_estrela_i[j]
                        if aux  < sensitivity[i, 2]
                            sensitivity[i, 2] = aux
                        end
                    end
                end
            end
        end

        print_matrix("Sensitivity Matrix", sensitivity)

        println("Variable Sensitivity")
        for i in eachindex(b_indices)
            @printf("x%d: [%f, %f]\n", b_indices[i], b_estrela[i] - sensitivity[i, 1], b_estrela[i] + sensitivity[i, 2])
        end
    end


    function print_variables_values_and_duals(x_values_B, b_indices, dual_variables)
        for i in eachindex(b_indices)
            @printf("x%d = %d | dual = %d\n", b_indices[i], x_values_B[i], dual_variables[i])
        end
    end

    function print_matrix(name, matrix)
        println(name)
        rows, cols = size(matrix)
        for i in 1:rows
            for j in 1:cols
                @printf("%6.2f ", matrix[i, j])
            end
            println()
        end
    end

    function dual_model(c, c_type, A, A_types, b, variable_types)
        dual_c_type = -c_type
        dual_b = c
        dual_c = b
    
        rows, columns = size(A)
        dual_A = zeros(BigFloat, columns, rows)
    
        for i in 1:columns
            dual_A[i, :] = A[:, i]
        end
    
        dual_a_types = -variable_types
        dual_variables_types = A_types
        
        return dual_c, dual_c_type, dual_A, dual_a_types, dual_b, dual_variables_types
    end

    function initialize(c, c_type, A, A_types, b)
        c::Array{BigFloat}
        A::Array{BigFloat}
        b::Array{BigFloat}

        if c_type == -1
            c = -c
        end

        size_c = size(c)

        dummies = Int64[]
        rows, columns = size(A)
        A_aux = []
        number_aux = 0

        for i in eachindex(A_types)
            if A_types[i] == -1
                number_aux += 2
            elseif A_types[i] == 1
                number_aux += 1
            else
                number_aux += 1
            end
        end

        A_aux = zeros(BigFloat, rows, number_aux)

        aux_matrix = 0

        for i in eachindex(A_types)
            if A_types[i] == 1
                A_aux[i, i + aux_matrix] = 1
            elseif A_types[i] == -1
                A_aux[i, i + aux_matrix] = -1
                A_aux[i, i + 1 + aux_matrix] = 1
                push!(dummies, i + 1 + aux_matrix)
                aux_matrix += 1
            else
                A_aux[i, i + aux_matrix] = 1
                push!(dummies, i + aux_matrix)
            end
        end

        rows, columns = size(A)
        A = hcat(A, A_aux)
        c = vcat(c, zeros(BigFloat, number_aux))

        for i in eachindex(dummies)
            c[size_c[1] + dummies[i]] = -99999
        end

        b_indices, x_values_B, B = initial_basis(A, b)

        return b_indices, x_values_B, B, A, c, dummies
    end

    function pricing_function(c, dual_variables, A, b)
        n = size(c)
        pricing_values = zeros(n)
    
        for index in eachindex(c)
            if !(index in b)
                pricing_values[index] = c[index] - dot(dual_variables, A[:, index])
            end
        end
    
        return pricing_values
    end

    function dual_variables_function(c, B, b)
        rows, columns = size(B)
        c_B = zeros(columns)

        for i in 1:columns
            c_B[i] = c[b[i]]
        end

        return B'\c_B
    end

    function initial_basis(A, b)
        rows, columns = size(A)

        comb = collect(combinations(1:columns, rows))
        for index in comb
            B = A[:, index]
            try
                x_values_B = inv(B) * b
                if all(x_values_B .>= 1e-6)
                    return index, x_values_B, B
                end
            catch e
                continue
            end
        end

        error("Infeasible")
    end
end 
