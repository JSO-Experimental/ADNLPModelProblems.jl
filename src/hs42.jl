function hs42_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> (x[1] - 1)^2 + (x[2] - 2)^2 + (x[3] - 3)^2 + (x[4] - 4)^2,
        ones(T, 4),
        x -> [x[3]^2 + x[4]^2 - 2; x[1] - 2],
        zeros(2),
        zeros(2),
        name = "hs42_radnlp",
    )
end

function hs42_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    adbackend = ADNLPModels.ForwardDiffAD(),
) where {T}
    return ADNLPModel(
        x -> (x[1] - 1)^2 + (x[2] - 2)^2 + (x[3] - 3)^2 + (x[4] - 4)^2,
        ones(T, 4),
        x -> [x[3]^2 + x[4]^2 - 2; x[1] - 2],
        zeros(2),
        zeros(2),
        name = "hs42_autodiff",
        adbackend = adbackend,
    )
end
