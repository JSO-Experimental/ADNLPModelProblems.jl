function fletcbv2_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n ≥ 2 || error("fletcbv2 : n ≥ 2")
    function f(x)
        n = length(x)
        h = 1.0 / (n + 1)
        return 0.5 * (x[1]^2 + sum((x[i] - x[i+1])^2 for i = 1:n-1) + x[n]^2) -
               h^2 * sum(2 * x[i] + cos(x[i]) for i = 1:n) - x[n]
    end
    x0 = T.([(i / (n + 1.0)) for i = 1:n])
    return RADNLPModel(f, x0, name = "fletcbv2_radnlp"; kwargs...)
end

function fletcbv2_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n ≥ 2 || error("fletcbv2 : n ≥ 2")
    function f(x)
        n = length(x)
        h = 1.0 / (n + 1)
        return 0.5 * (x[1]^2 + sum((x[i] - x[i+1])^2 for i = 1:n-1) + x[n]^2) -
               h^2 * sum(2 * x[i] + cos(x[i]) for i = 1:n) - x[n]
    end
    x0 = T.([(i / (n + 1.0)) for i = 1:n])
    return ADNLPModel(f, x0, name = "fletcbv2_autodiff"; kwargs...)
end

fletcbv2_meta = Dict(
    :nvar => 100,
    :variable_size => false,
    :ncon => 0,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 0,
    :minimize => true,
    :name => "fletcbv2",
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
