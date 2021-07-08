function hs27_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> 0.01 * (x[1] - 1)^2 + (x[2] - x[1]^2)^2,
        2ones(T, 3),
        x -> [x[1] + x[3]^2 + 1],
        [0.0],
        [0.0],
        name = "hs27_radnlp",
    )
end

function hs27_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return ADNLPModel(
        x -> 0.01 * (x[1] - 1)^2 + (x[2] - x[1]^2)^2,
        2ones(T, 3),
        x -> [x[1] + x[3]^2 + 1],
        [0.0],
        [0.0],
        name = "hs27_autodiff";
        kwargs...,
    )
end

hs27_meta = Dict(
    :nvar => 3,
    :variable_size => false,
    :ncon => 1,
    :variable_con_size => false,
    :nnzo => 3,
    :nnzh => 6,
    :nnzj => 3,
    :minimize => true,
    :name => "hs27",
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
    :has_equalities_only => true,
    :has_inequalities_only => false,
    :has_bounds => false,
    :has_fixed_variables => false,
    :cqs => 0,
)

get_hs27_meta(; n::Int=default_nvar) = (hs27_meta[:nvar], hs27_meta[:ncon])
