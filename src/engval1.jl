function engval1_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n ≥ 2 || error("engval : n ≥ 2")
    function f(x)
        n = length(x)
        return sum((x[i]^2 + x[i+1]^2)^2 - 4 * x[i] + 3 for i = 1:n-1)
    end
    x0 = 2 * ones(T, n)
    return RADNLPModel(f, x0, name = "engval1_radnlp"; kwargs...)
end

function engval1_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n ≥ 2 || error("engval : n ≥ 2")
    function f(x)
        n = length(x)
        return sum((x[i]^2 + x[i+1]^2)^2 - 4 * x[i] + 3 for i = 1:n-1)
    end
    x0 = 2 * ones(T, n)
    return ADNLPModel(f, x0, name = "engval1_autodiff"; kwargs...)
end

engval1_meta = Dict(
    :nvar => 100,
    :variable_size => false,
    :ncon => 0,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 0,
    :minimize => true,
    :name => "engval1",
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
