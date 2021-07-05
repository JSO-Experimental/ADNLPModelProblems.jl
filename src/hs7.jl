function hs7_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> log(1 + x[1]^2) - x[2],
        [2.0; 2.0],
        x -> [(1 + x[1]^2)^2 + x[2]^2 - 4],
        [0.0],
        [0.0],
        name = "hs7_radnlp",
    )
end

function hs7_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    return ADNLPModel(
        x -> log(1 + x[1]^2) - x[2],
        [2.0; 2.0],
        x -> [(1 + x[1]^2)^2 + x[2]^2 - 4],
        [0.0],
        [0.0],
        name = "hs7_autodiff",
        kwargs...,
    )
end
