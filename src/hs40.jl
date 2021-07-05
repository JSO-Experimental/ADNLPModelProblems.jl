function hs40_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> -x[1] * x[2] * x[3] * x[4],
        0.8ones(T, 4),
        x -> [x[1]^3 + x[2]^2 - 1; x[4] * x[1]^2 - x[3]; x[4]^2 - x[2]],
        zeros(3),
        zeros(3),
        name = "hs40_radnlp",
    )
end

function hs40_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    return ADNLPModel(
        x -> -x[1] * x[2] * x[3] * x[4],
        0.8ones(T, 4),
        x -> [x[1]^3 + x[2]^2 - 1; x[4] * x[1]^2 - x[3]; x[4]^2 - x[2]],
        zeros(3),
        zeros(3),
        name = "hs40_autodiff",
        kwargs...,
    )
end
