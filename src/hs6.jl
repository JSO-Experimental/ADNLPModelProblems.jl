function hs6_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> (x[1] - 1)^2,
        [-1.2; 1.0],
        x -> [10 * (x[2] - x[1]^2)],
        zeros(1),
        zeros(1),
        name = "hs6_radnlp",
    )
end

function hs6_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    return ADNLPModel(
        x -> (x[1] - 1)^2,
        [-1.2; 1.0],
        x -> [10 * (x[2] - x[1]^2)],
        zeros(1),
        zeros(1),
        name = "hs6_autodiff",
        kwargs...,
    )
end

hs6_meta = Dict(    :nvar => 2,    :variable_size => false,    :ncon => 1,    :variable_con_size => false,    :nnzo => 2,    :nnzh => 3,    :nnzj => 2,    :minimize => true,    :name => "hs6",    :optimal_value => NaN,    :has_multiple_solution => missing,    :is_infeasible => missing,    :objtype => :other,      :contype => :general,    :origin => :unknown,    :deriv => typemax(UInt8),    :not_everywhere_defined => missing,    :has_cvx_obj => false,    :has_cvx_con => false,    :has_equalities_only => true,    :has_inequalities_only => false,    :has_bounds => false,    :has_fixed_variables => false,    :cqs => 0,  )
