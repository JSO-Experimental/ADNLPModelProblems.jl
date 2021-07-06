function chnrosnb_mod_radnlp(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    n ≥ 2 || ("chnrosnb : n ≥ 2")
    function f(x)
        n = length(x)
        return 16 * sum((x[i-1] - x[i]^2)^2 * (1.5 + sin(i))^2 for i = 2:n) +
               sum((1.0 - x[i])^2 for i = 2:n)
    end
    x0 = -ones(T, n)
    return RADNLPModel(f, x0, name = "chnrosnb_radnlp"; kwargs...)
end

function chnrosnb_mod_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...
) where {T}
    n ≥ 2 || ("chnrosnb : n ≥ 2")
    function f(x)
        n = length(x)
        return 16 * sum((x[i-1] - x[i]^2)^2 * (1.5 + sin(i))^2 for i = 2:n) +
               sum((1.0 - x[i])^2 for i = 2:n)
    end
    x0 = -ones(T, n)
    return ADNLPModel(f, x0, name = "chnrosnb_autodiff"; kwargs...)
end

chnrosnb_mod_meta = Dict(    :nvar => 100,    :variable_size => false,    :ncon => 0,    :variable_con_size => false,    :nnzo => 100,    :nnzh => 5050,    :nnzj => 0,    :minimize => true,    :name => "chnrosnb_mod",    :optimal_value => NaN,    :has_multiple_solution => missing,    :is_infeasible => false,    :objtype => :other,      :contype => :unconstrained,    :origin => :unknown,    :deriv => typemax(UInt8),    :not_everywhere_defined => missing,    :has_cvx_obj => false,    :has_cvx_con => false,    :has_equalities_only => false,    :has_inequalities_only => false,    :has_bounds => false,    :has_fixed_variables => false,    :cqs => 0,  )
