function beale_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    function f(x)
        n = length(x)
        return (1.5 + x[1] * (1.0 - x[2]))^2 +
               (2.25 + x[1] * (1.0 - x[2]^2))^2 +
               (2.625 + x[1] * (1.0 - x[2]^3))^2
    end
    x0 = ones(T, n)
    return RADNLPModel(f, x0, name = "beale_radnlp"; kwargs...)
end

function beale_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    function f(x)
        n = length(x)
        return (1.5 + x[1] * (1.0 - x[2]))^2 +
               (2.25 + x[1] * (1.0 - x[2]^2))^2 +
               (2.625 + x[1] * (1.0 - x[2]^3))^2
    end
    x0 = ones(T, n)
    return ADNLPModel(f, x0, name = "beale_autodiff"; kwargs...)
end

beale_meta = Dict(
    :nvar => 100,
    :variable_size => false,
    :ncon => 0,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 0,
    :minimize => true,
    :name => "beale",
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

get_beale_meta(; n::Int=default_nvar) = (beale_meta[:nvar], beale_meta[:ncon])
