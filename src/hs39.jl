function hs39_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> -x[1],
        2ones(T, 4),
        x -> [x[2] - x[1]^3 - x[3]^2; x[1]^2 - x[2] - x[4]^2],
        zeros(2),
        zeros(2),
        name = "hs39_radnlp",
    )
end

function hs39_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    adbackend = ADNLPModels.ForwardDiffAD(),
) where {T}
    return ADNLPModel(
        x -> -x[1],
        2ones(T, 4),
        x -> [x[2] - x[1]^3 - x[3]^2; x[1]^2 - x[2] - x[4]^2],
        zeros(2),
        zeros(2),
        name = "hs39_autodiff",
        adbackend = adbackend,
    )
end
