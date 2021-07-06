function nondquar_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    function f(x)
        n = length(x)
        return (x[1] - x[2])^2 +
               (x[n-1] - x[n])^2 +
               sum((x[i] + x[i+1] + x[n])^4 for i = 1:n-2)
    end

    x0 = ones(T, n)
    x0[2*collect(1:div(n, 2))] .= -one(T)
    return RADNLPModel(f, x0, name = "nondquar_radnlp"; kwargs...)
end

function nondquar_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    function f(x)
        n = length(x)
        return (x[1] - x[2])^2 +
               (x[n-1] - x[n])^2 +
               sum((x[i] + x[i+1] + x[n])^4 for i = 1:n-2)
    end

    x0 = ones(T, n)
    x0[2*collect(1:div(n, 2))] .= -one(T)
    return ADNLPModel(f, x0,  name = "nondquar_autodiff"; kwargs...)
end

nondquar_meta = Dict(    :nvar => 100,    :variable_size => false,    :ncon => 0,    :variable_con_size => false,    :nnzo => 100,    :nnzh => 5050,    :nnzj => 0,    :minimize => true,    :name => "nondquar",    :optimal_value => NaN,    :has_multiple_solution => missing,    :is_infeasible => false,    :objtype => :other,      :contype => :unconstrained,    :origin => :unknown,    :deriv => typemax(UInt8),   
 :not_everywhere_defined => missing,    :has_cvx_obj => false,    :has_cvx_con => false,    :has_equalities_only => false,    :has_inequalities_only => false,    :has_bounds => false,    :has_fixed_variables => false,    :cqs => 0,  )
