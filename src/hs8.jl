function hs8_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> -1.0,
        [2.0; 1.0],
        x -> [x[1]^2 + x[2]^2 - 25; x[1] * x[2] - 9],
        zeros(2),
        zeros(2),
        name = "hs8_radnlp",
    )
end

function hs8_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return ADNLPModel(
        x -> -1.0,
        [2.0; 1.0],
        x -> [x[1]^2 + x[2]^2 - 25; x[1] * x[2] - 9],
        zeros(2),
        zeros(2),
        name = "hs8_autodiff";
        kwargs...,
    )
end

hs8_meta = Dict(
    :nvar => 2,
    :variable_size => false,
    :ncon => 2,
    :variable_con_size => false,
    :nnzo => 2,
    :nnzh => 3,
    :nnzj => 4,
    :minimize => true,
    :name => "hs8",
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

get_hs8_meta(; n::Int=default_nvar) = (hs8_meta[:nvar], hs8_meta[:ncon])
