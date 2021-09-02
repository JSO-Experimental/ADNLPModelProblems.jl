#=
https://nbviewer.jupyter.org/urls/laurentlessard.com/teaching/cs524/examples/Polygon.ipynb

Largest inscribed polygon

T.M.: origin problem is a Max.
=#

function polygon1(args...; n = 100, kwargs...)
    m = Model()
    N = div(n, 2)
    @variable(m, 0 <= r[1:N] <= 1)
    @variable(m, 0 <= θ[1:N] <= 2π)

    # impose an order to the angles
    @constraint(m, θ[1] == 0)
    for i = 1:N-1
        @constraint(m, θ[i+1] >= θ[i])
    end

    @NLobjective(
        m,
        Min,
        -0.5 * sum(r[i] * r[i+1] * sin(θ[i+1] - θ[i]) for i = 1:N-1) -
        0.5 * r[1] * r[N] * sin(θ[1] - θ[N])
    )
    return m
end

function polygon1_autodiff(
    args...;
    n::Int = 200,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    N = div(n, 2)
    function f(y)
        r, θ = y[1:N], y[N+1:end]
        return -0.5 * sum(r[i] * r[i+1] * sin(θ[i+1] - θ[i]) for i = 1:N-1) -
               0.5 * r[1] * r[N] * sin(θ[1] - θ[N])
    end
    function c(y)
        r, θ = y[1:N], y[N+1:end]
        return vcat([θ[i+1] - θ[i] for i = 1:N-1], θ[1])
    end
    lvar = vcat(zeros(T, N), zeros(T, N))
    uvar = vcat(ones(T, N), 2π * ones(T, N))
    xi = zeros(T, 2 * N)
    return ADNLPModel(
        f,
        xi,
        lvar,
        uvar,
        c,
        vcat(Inf * ones(T, N - 1), 0),
        zeros(T, N),
        name = "polygon1_autodiff";
        kwargs...,
    )
end

polygon1_meta = Dict(
    :nvar => 2 * div(default_nvar, 2),
    :variable_size => true,
    :ncon => div(default_nvar, 2),
    :variable_con_size => true,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 5000,
    :minimize => true,
    :name => "polygon1",
    :optimal_value => NaN,
    :has_multiple_solution => missing,
    :is_infeasible => missing,
    :objtype => :other,
    :contype => :general,
    :origin => :unknown,
    :deriv => typemax(UInt8),
    :not_everywhere_defined => missing,
    :has_cvx_obj => false,
    :has_cvx_con => false,
    :has_equalities_only => false,
    :has_inequalities_only => false,
    :has_bounds => true,
    :has_fixed_variables => false,
    :cqs => 0,
)

get_polygon1_meta(; n::Integer = default_nvar) = (2 * div(n, 2), div(n, 2))
