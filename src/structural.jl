#=
https://nbviewer.jupyter.org/urls/laurentlessard.com/teaching/cs524/examples/Structural%20optimization.ipynb

Structural optimization
=#
function structural(args...; n = 100, kwargs...)

    sub2ind(shape, a, b) = LinearIndices(shape)[CartesianIndex.(a, b)]
    Nx = min(Int(round(n^(1 / 3))), 6)
    Ny = Int(round(n^(1 / 3)))
    # FIXED NODES
    fixed = [sub2ind((Nx, Ny), i, 1) for i = 3:Nx]

    # crunching
    #loaded = [ (sub2ind((Nx,Ny),i,Ny), 0,1) for i = 4:5 ]

    # uniform lateral load
    loaded1 = [(sub2ind((Nx, Ny), 4, j), 1, 0) for j = 1:Ny]
    loaded2 = [(sub2ind((Nx, Ny), 5, j), 1, 0) for j = 1:Ny]
    loaded = [loaded1; loaded2]

    N = Nx * Ny  # number of nodes

    # NODES: columns are x and y components respectively
    nodes = [kron(ones(Ny), collect(1:Nx)) kron(collect(1:Ny), ones(Nx))]

    M = Int(N * (N - 1) / 2)  # number of edges

    # EDGES: columns are the indices of the nodes at either end
    edges = Array{Int}(zeros(M, 2))

    k = 0
    for i = 1:N
        for j = 1:i-1
            k = k + 1
            edges[k, :] = [i j]
        end
    end

    ℓ = zeros(M)
    nx = zeros(N, M)
    ny = zeros(N, M)
    for j = 1:M
        i1 = edges[j, 1]
        i2 = edges[j, 2]
        ℓ[j] = norm([nodes[i1, 1] - nodes[i2, 1], nodes[i1, 2] - nodes[i2, 2]])
        nx[i1, j] = (nodes[i1, 1] - nodes[i2, 1]) / ℓ[j]
        nx[i2, j] = (nodes[i2, 1] - nodes[i1, 1]) / ℓ[j]
        ny[i1, j] = (nodes[i1, 2] - nodes[i2, 2]) / ℓ[j]
        ny[i2, j] = (nodes[i2, 2] - nodes[i1, 2]) / ℓ[j]
    end

    fx = zeros(N)
    fy = zeros(N)
    for L in loaded
        ind = L[1]
        fx[ind] = L[2]
        fy[ind] = L[3]
    end

    m = Model()

    @variable(m, x[1:M] >= 0)   # area of edge from i to j
    @variable(m, u[1:M])       # force in edge from i to j

    for i = 1:N
        if i in fixed
            continue
        else
            @constraint(m, sum(u[j] * nx[i, j] for j = 1:M) + fx[i] == 0)
            @constraint(m, sum(u[j] * ny[i, j] for j = 1:M) + fy[i] == 0)
        end
    end

    @constraint(m, -x .<= u)
    @constraint(m, u .<= x)

    @objective(m, Min, sum(ℓ[j] * x[j] for j = 1:M))

    return m
end

function structural_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    sub2ind(shape, a, b) = LinearIndices(shape)[CartesianIndex.(a, b)]
    Nx = min(Int(round(n^(1 / 3))), 6)
    Ny = Int(round(n^(1 / 3)))
    # FIXED NODES
    fixed = [sub2ind((Nx, Ny), i, 1) for i = 3:Nx]

    # crunching
    #loaded = [ (sub2ind((Nx,Ny),i,Ny), 0,1) for i = 4:5 ]

    # uniform lateral load
    loaded1 = [(sub2ind((Nx, Ny), 4, j), 1, 0) for j = 1:Ny]
    loaded2 = [(sub2ind((Nx, Ny), 5, j), 1, 0) for j = 1:Ny]
    loaded = [loaded1; loaded2]
    N = Nx * Ny  # number of nodes

    # NODES: columns are x and y components respectively
    nodes = [kron(ones(Ny), collect(1:Nx)) kron(collect(1:Ny), ones(Nx))]

    M = Int(N * (N - 1) / 2)  # number of edges

    # EDGES: columns are the indices of the nodes at either end
    edges = Array{Int}(zeros(M, 2))

    k = 0
    for i = 1:N
        for j = 1:i-1
            k = k + 1
            edges[k, :] = [i j]
        end
    end

    ℓ = zeros(M)
    nx = zeros(N, M)
    ny = zeros(N, M)
    for j = 1:M
        i1 = edges[j, 1]
        i2 = edges[j, 2]
        ℓ[j] = norm([nodes[i1, 1] - nodes[i2, 1], nodes[i1, 2] - nodes[i2, 2]])
        nx[i1, j] = (nodes[i1, 1] - nodes[i2, 1]) / ℓ[j]
        nx[i2, j] = (nodes[i2, 1] - nodes[i1, 1]) / ℓ[j]
        ny[i1, j] = (nodes[i1, 2] - nodes[i2, 2]) / ℓ[j]
        ny[i2, j] = (nodes[i2, 2] - nodes[i1, 2]) / ℓ[j]
    end

    fx = zeros(N)
    fy = zeros(N)
    for L in loaded
        ind = L[1]
        fx[ind] = L[2]
        fy[ind] = L[3]
    end
    function f(y)
        x, u = y[1:M], y[M+1:2*M]
        return sum(ℓ[j] * x[j] for j = 1:M)
    end
    function c(y)
        x, u = y[1:M], y[M+1:2*M]
        return vcat(
            [sum(u[j] * nx[i, j] for j = 1:M) + fx[i] for i in setdiff(1:N, fixed)],
            [sum(u[j] * ny[i, j] for j = 1:M) + fy[i] for i in setdiff(1:N, fixed)],
        )
    end
    lcon = zeros(T, 2 * (N - length(fixed)))
    ucon = zeros(T, 2 * (N - length(fixed)))
    x0 = ones(T, 2 * M)
    lvar = vcat(zeros(T, M), -Inf * ones(T, M))
    uvar = Inf * ones(T, 2 * M)
    return ADNLPModel(
        f,
        x0,
        lvar,
        uvar,
        c,
        lcon,
        ucon,
        name = "structural_autodiff",
        kwargs...,
    )
end

function structural_radnlp(; n::Int = 100, type::Val{T} = Val(Float64)) where {T}
    Nx = min(Int(round(n^(1 / 3))), 6)
    Ny = Int(round(n^(1 / 3)))
    # FIXED NODES
    fixed = [sub2ind((Nx, Ny), i, 1) for i = 3:Nx]

    # crunching
    #loaded = [ (sub2ind((Nx,Ny),i,Ny), 0,1) for i = 4:5 ]

    # uniform lateral load
    loaded1 = [(sub2ind((Nx, Ny), 4, j), 1, 0) for j = 1:Ny]
    loaded2 = [(sub2ind((Nx, Ny), 5, j), 1, 0) for j = 1:Ny]
    loaded = [loaded1; loaded2]
    N = Nx * Ny  # number of nodes

    # NODES: columns are x and y components respectively
    nodes = [kron(ones(Ny), collect(1:Nx)) kron(collect(1:Ny), ones(Nx))]

    M = Int(N * (N - 1) / 2)  # number of edges

    # EDGES: columns are the indices of the nodes at either end
    edges = Array{Int}(zeros(M, 2))

    k = 0
    for i = 1:N
        for j = 1:i-1
            k = k + 1
            edges[k, :] = [i j]
        end
    end

    ℓ = zeros(M)
    nx = zeros(N, M)
    ny = zeros(N, M)
    for j = 1:M
        i1 = edges[j, 1]
        i2 = edges[j, 2]
        ℓ[j] = norm([nodes[i1, 1] - nodes[i2, 1], nodes[i1, 2] - nodes[i2, 2]])
        nx[i1, j] = (nodes[i1, 1] - nodes[i2, 1]) / ℓ[j]
        nx[i2, j] = (nodes[i2, 1] - nodes[i1, 1]) / ℓ[j]
        ny[i1, j] = (nodes[i1, 2] - nodes[i2, 2]) / ℓ[j]
        ny[i2, j] = (nodes[i2, 2] - nodes[i1, 2]) / ℓ[j]
    end

    fx = zeros(N)
    fy = zeros(N)
    for L in loaded
        ind = L[1]
        fx[ind] = L[2]
        fy[ind] = L[3]
    end
    function f(y)
        x, u = y[1:M], y[M+1:2*M]
        return sum(ℓ[j] * x[j] for j = 1:M)
    end
    function c(y)
        x, u = y[1:M], y[M+1:2*M]
        return vcat(
            [sum(u[j] * nx[i, j] for j = 1:M) + fx[i] for i in setdiff(1:N, fixed)],
            [sum(u[j] * ny[i, j] for j = 1:M) + fy[i] for i in setdiff(1:N, fixed)],
        )
    end
    lcon = zeros(T, 2 * (N - length(fixed)))
    ucon = zeros(T, 2 * (N - length(fixed)))
    x0 = ones(T, 2 * M)
    lvar = vcat(zeros(T, M), -Inf * ones(T, M))
    uvar = Inf * ones(T, 2 * M)
    return RADNLPModel(f, x0, lvar, uvar, c, lcon, ucon, name = "structural_radnlp")
end

structural_meta = Dict(    :nvar => 600,    :variable_size => false,    :ncon => 44,    :variable_con_size => false,    :nnzo => 600,    :nnzh => 180300,    :nnzj => 26400,    :minimize => true,    :name => "structural",    :optimal_value => NaN,    :has_multiple_solution => missing,    :is_infeasible => missing,    :objtype => :other,      :contype => :general,    :origin => :unknown,    :deriv => typemax(UInt8),    :not_everywhere_defined => missing,    :has_cvx_obj => false,    :has_cvx_con => false,    :has_equalities_only => true,    :has_inequalities_only => false,    :has_bounds => true,    :has_fixed_variables 
=> false,    :cqs => 0,  )
