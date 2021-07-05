function hs9_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> sin(π * x[1] / 12) * cos(π * x[2] / 16),
        zeros(T, 2),
        x -> [4 * x[1] - 3 * x[2]],
        [0.0],
        [0.0],
        name = "hs9_radnlp",
    )
end

function hs9_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    return ADNLPModel(
        x -> sin(π * x[1] / 12) * cos(π * x[2] / 16),
        zeros(T, 2),
        x -> [4 * x[1] - 3 * x[2]],
        [0.0],
        [0.0],
        name = "hs9_autodiff",
        kwargs...,
    )
end
