#=
https://nbviewer.jupyter.org/urls/laurentlessard.com/teaching/cs524/examples/Polygon.ipynb

Largest inscribed polygon

T.M.: origin problem is a Max.
=#

function polygon2(args...; n::Int = default_nvar, kwargs...)
    m = Model()
    N = div(n, 2)
    @variable(m, 0 <= r[1:N] <= 1)
    @variable(m, α[1:N] >= 0)


    # impose an order to the angles
    @constraint(m, sum(α) == 2π)

    @NLobjective(
        m,
        Min,
        -0.5 * sum(r[i] * r[i+1] * sin(α[i]) for i = 1:N-1) - 0.5 * r[1] * r[N] * sin(α[N])
    )
    return m
end

function polygon2_autodiff(
    args...;
    n::Int = 200,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    N = div(n, 2)
    function f(y)
        r, α = y[1:N], y[N+1:end]
        return -0.5 * sum(r[i] * r[i+1] * sin(α[i]) for i = 1:N-1) -
               0.5 * r[1] * r[N] * sin(α[N])
    end
    function c(y)
        r, α = y[1:N], y[N+1:end]
        return [sum(α) - 2π]
    end
    lvar = vcat(zeros(T, N), zeros(T, N))
    uvar = vcat(ones(T, N), Inf * ones(T, N))
    xi = zeros(T, 2 * N)
    return ADNLPModel(
        f,
        xi,
        lvar,
        uvar,
        c,
        zeros(T, 1),
        zeros(T, 1),
        name = "polygon2_autodiff";
        kwargs...,
    )
end

polygon2_meta = Dict(
    :nvar => 2 * div(default_nvar, 2),
    :variable_size => true,
    :ncon => 1,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 100,
    :minimize => true,
    :name => "polygon2",
    :optimal_value => NaN,
    :has_multiple_solution => missing,
    :is_infeasible => missing,
    :objtype => :other,
    :contype => :general,
    :origin => :unknown,
    :deriv => typemax(UInt8),
    :not_everywhere_defined => false,
    :has_cvx_obj => false,
    :has_cvx_con => false,
    :has_equalities_only => true,
    :has_inequalities_only => false,
    :has_bounds => true,
    :has_fixed_variables => false,
    :cqs => 0,
)

get_polygon2_meta(; n::Integer = default_nvar) = (2 * div(n, 2), polygon2_meta[:ncon])
