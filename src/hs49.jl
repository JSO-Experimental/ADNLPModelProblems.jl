function hs49_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> (x[1] - x[2])^2 + (x[3] - 1)^2 + (x[4] - 1)^4 + (x[5] - 1)^6,
        [10.0, 7.0, 2.0, -3.0, 0.8],
        x -> [x[1] + x[2] + x[3] + 4 * x[4] - 7; x[3] + 5 * x[5] - 6],
        zeros(2),
        zeros(2),
        name = "hs49_radnlp",
    )
end

function hs49_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    adbackend = ADNLPModels.ForwardDiffAD(),
) where {T}
    return ADNLPModel(
        x -> (x[1] - x[2])^2 + (x[3] - 1)^2 + (x[4] - 1)^4 + (x[5] - 1)^6,
        [10.0, 7.0, 2.0, -3.0, 0.8],
        x -> [x[1] + x[2] + x[3] + 4 * x[4] - 7; x[3] + 5 * x[5] - 6],
        zeros(2),
        zeros(2),
        name = "hs49_autodiff",
        adbackend = adbackend,
    )
end
