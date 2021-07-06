function vardim_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    function f(x)
        n = length(x)
        return sum((x[i] - 1)^2 for i = 1:n) +
               sum(i * (x[i] - 1) for i = 1:n)^2 +
               sum(i * (x[i] - 1) for i = 1:n)^4
    end

    x0 = T.([1 - i / n for i = 1:n])
    return RADNLPModel(f, x0, name = "vardim_radnlp"; kwargs...)
end

function vardim_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    function f(x)
        n = length(x)
        return sum((x[i] - 1)^2 for i = 1:n) +
               sum(i * (x[i] - 1) for i = 1:n)^2 +
               sum(i * (x[i] - 1) for i = 1:n)^4
    end

    x0 = T.([1 - i / n for i = 1:n])
    return ADNLPModel(f, x0, name = "vardim_autodiff"; kwargs...)
end

vardim_meta = Dict(
    :nvar => 100,
    :variable_size => false,
    :ncon => 0,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 0,
    :minimize => true,
    :name => "vardim",
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
