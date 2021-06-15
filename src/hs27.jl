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

function hs27_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    adbackend = ADNLPModels.ForwardDiffAD(),
) where {T}
    return ADNLPModel(
        x -> 0.01 * (x[1] - 1)^2 + (x[2] - x[1]^2)^2,
        2ones(T, 3),
        x -> [x[1] + x[3]^2 + 1],
        [0.0],
        [0.0],
        name = "hs27_autodiff",
        adbackend = adbackend,
    )
end
