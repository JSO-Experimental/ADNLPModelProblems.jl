function scosine_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n ≥ 2 || error("scosine : n ≥ 2")
    p = zeros(n)
    for i = 1:n
        p[i] = exp(6.0 * (i - 1) / (n - 1))
    end
    function f(x)
        n = length(x)
        return sum(cos(p[i]^2 * x[i]^2 - p[i+1] * x[i+1] / 2.0) for i = 1:n-1)
    end
    x0 = T.([1 / p[i] for i = 1:n])
    return ADNLPModel(f, x0, name = "scosine_autodiff"; kwargs...)
end

scosine_meta = Dict(
    :nvar => 100,
    :variable_size => false,
    :ncon => 0,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 0,
    :minimize => true,
    :name => "scosine",
    :optimal_value => NaN,
    :has_multiple_solution => missing,
    :is_infeasible => false,
    :objtype => :other,
    :contype => :unconstrained,
    :origin => :unknown,
    :deriv => typemax(UInt8),
    :not_everywhere_defined => missing,
    :has_cvx_obj => false,
    :has_cvx_con => false,
    :has_equalities_only => false,
    :has_inequalities_only => false,
    :has_bounds => false,
    :has_fixed_variables => false,
    :cqs => 0,
)

get_scosine_meta(; n::Int=default_nvar) = (scosine_meta[:nvar], scosine_meta[:ncon])
