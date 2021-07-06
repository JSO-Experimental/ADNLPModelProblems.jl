#=
https://nbviewer.jupyter.org/urls/laurentlessard.com/teaching/cs524/examples/Polygon.ipynb

Largest inscribed polygon

T.M.: origin problem is a Max.
=#

function polygon3(args...; n = 100, kwargs...)
    m = Model()
    N = div(n, 2)
    @variable(m, x[1:N])
    @variable(m, y[1:N])


    for i = 1:N
        @NLconstraint(m, x[i]^2 + y[i]^2 <= 1)
    end

    # add ordering constraint to the vertices
    for i = 1:N-1
        @constraint(m, x[i] * y[i+1] - y[i] * x[i+1] >= 0)
    end
    @NLconstraint(m, x[N] * y[1] - y[N] * x[1] >= 0)

    @NLobjective(
        m,
        Min,
        -0.5 * sum(x[i] * y[i+1] - y[i] * x[i+1] for i = 1:N-1) -
        0.5 * (x[N] * y[1] - y[N] * x[1])
    )
    return m
end

function polygon3_autodiff(
    args...;
    n::Int = 200,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    N = div(n, 2)
    function f(y)
        x, y = y[1:N], y[N+1:end]
        return -0.5 * sum(x[i] * y[i+1] - y[i] * x[i+1] for i = 1:N-1) -
               0.5 * (x[N] * y[1] - y[N] * x[1])
    end
    function c(y)
        x, y = y[1:N], y[N+1:end]
        return vcat(
            [x[i]^2 + y[i]^2 for i = 1:N],
            [x[i] * y[i+1] - y[i] * x[i+1] for i = 1:N-1],
            x[N] * y[1] - y[N] * x[1],
        )
    end
    xi = zeros(T, 2 * N)
    return ADNLPModel(
        f,
        xi,
        c,
        vcat(-Inf * ones(T, N), zeros(T, N)),
        vcat(ones(T, N), Inf * ones(T, N)),
        name = "polygon3_autodiff";
        kwargs...,
    )
end

function polygon3_radnlp(
    args...;
    n::Int = 200,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    N = div(n, 2)
    function f(y)
        x, y = y[1:N], y[N+1:end]
        return -0.5 * sum(x[i] * y[i+1] - y[i] * x[i+1] for i = 1:N-1) -
               0.5 * (x[N] * y[1] - y[N] * x[1])
    end
    function c(y)
        x, y = y[1:N], y[N+1:end]
        return vcat(
            [x[i]^2 + y[i]^2 for i = 1:N],
            [x[i] * y[i+1] - y[i] * x[i+1] for i = 1:N-1],
            x[N] * y[1] - y[N] * x[1],
        )
    end
    xi = zeros(T, 2 * N)
    return RADNLPModel(
        f,
        xi,
        c,
        vcat(-Inf * ones(T, N), zeros(T, N)),
        vcat(ones(T, N), Inf * ones(T, N)),
        name = "polygon3_radnlp",
    )
end

polygon3_meta = Dict(    :nvar => 100,    :variable_size => false,    :ncon => 100,    :variable_con_size => false,    :nnzo => 100,    :nnzh => 5050,    :nnzj => 10000,    :minimize => true,    :name => "polygon3",    :optimal_value => NaN,    :has_multiple_solution => missing,    :is_infeasible => missing,    :objtype => :other,      :contype => :general,    :origin => :unknown,    :deriv => typemax(UInt8), 
   :not_everywhere_defined => missing,    :has_cvx_obj => false,    :has_cvx_con => false,    :has_equalities_only => false,    :has_inequalities_only => true,    :has_bounds => false,    :has_fixed_variables => false,    :cqs => 0,  )
