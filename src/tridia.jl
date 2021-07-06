function tridia_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}

    function f(x)
        n = length(x)
        return (x[1] - 1)^2 + sum(i * (-x[i-1] + 2 * x[i])^2 for i = 2:n)
    end
    x0 = ones(T, n)
    return RADNLPModel(f, x0, name = "tridia_radnlp"; kwargs...)
end

function tridia_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}

    function f(x)
        n = length(x)
        return (x[1] - 1)^2 + sum(i * (-x[i-1] + 2 * x[i])^2 for i = 2:n)
    end
    x0 = ones(T, n)
    return ADNLPModel(f, x0, name = "tridia_autodiff"; kwargs...)
end

tridia_meta = Dict(
    :nvar => 100,
    :variable_size => false,
    :ncon => 0,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 0,
    :minimize => true,
    :name => "tridia",
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
