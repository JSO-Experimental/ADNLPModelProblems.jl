function hs46_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return ADNLPModel(
        x -> (x[1] - x[2])^2 + (x[3] - 1)^2 + (x[4] - 1)^4 + (x[5] - 1)^6,
        [sqrt(2) / 2, 1.75, 0.5, 2.0, 2.0],
        x -> [(x[1]^2) * x[4] + sin(x[4] - x[5]) - 1; x[2] + (x[3]^4) * (x[4]^2) - 2],
        zeros(2),
        zeros(2),
        name = "hs46_autodiff";
        kwargs...,
    )
end

hs46_meta = Dict(
    :nvar => 5,
    :variable_size => false,
    :ncon => 2,
    :variable_con_size => false,
    :nnzo => 5,
    :nnzh => 15,
    :nnzj => 10,
    :minimize => true,
    :name => "hs46",
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

get_hs46_meta(; n::Int=default_nvar) = (hs46_meta[:nvar], hs46_meta[:ncon])
