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

function hs8_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    adbackend = ADNLPModels.ForwardDiffAD(),
) where {T}
    return ADNLPModel(
        x -> -1.0,
        [2.0; 1.0],
        x -> [x[1]^2 + x[2]^2 - 25; x[1] * x[2] - 9],
        zeros(2),
        zeros(2),
        adbackend = adbackend,
        name = "hs8_autodiff",
    )
end
