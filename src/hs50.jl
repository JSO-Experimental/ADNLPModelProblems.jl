function hs50_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> (x[1] - x[2])^2 + (x[2] - x[3])^2 + (x[3] - x[4])^4 + (x[4] - x[5])^2,
        [35.0, -31.0, 11.0, 5.0, -5.0],
        x -> [
            x[1] + 2 * x[2] + 3 * x[3] - 6
            x[2] + 2 * x[3] + 3 * x[4] - 6
            x[3] + 2 * x[4] + 3 * x[5] - 6
        ],
        zeros(3),
        zeros(3),
        name = "hs50_radnlp",
    )
end

function hs50_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    adbackend = ADNLPModels.ForwardDiffAD(),
) where {T}
    return ADNLPModel(
        x -> (x[1] - x[2])^2 + (x[2] - x[3])^2 + (x[3] - x[4])^4 + (x[4] - x[5])^2,
        [35.0, -31.0, 11.0, 5.0, -5.0],
        x -> [
            x[1] + 2 * x[2] + 3 * x[3] - 6
            x[2] + 2 * x[3] + 3 * x[4] - 6
            x[3] + 2 * x[4] + 3 * x[5] - 6
        ],
        zeros(3),
        zeros(3),
        name = "hs50_autodiff",
        adbackend = adbackend,
    )
end
