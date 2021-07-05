function hs48_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> (x[1] - 1)^2 + (x[2] - x[3])^2 + (x[4] - x[5])^2,
        [3.0, 5.0, -3.0, 2.0, -2.0],
        x -> [x[1] + x[2] + x[3] + x[4] + x[5] - 5; x[3] - 2 * (x[4] + x[5]) + 3],
        zeros(2),
        zeros(2),
        name = "hs48_radnlp",
    )
end

function hs48_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    return ADNLPModel(
        x -> (x[1] - 1)^2 + (x[2] - x[3])^2 + (x[4] - x[5])^2,
        [3.0, 5.0, -3.0, 2.0, -2.0],
        x -> [x[1] + x[2] + x[3] + x[4] + x[5] - 5; x[3] - 2 * (x[4] + x[5]) + 3],
        zeros(2),
        zeros(2),
        name = "hs48_autodiff",
        kwargs...,
    )
end
