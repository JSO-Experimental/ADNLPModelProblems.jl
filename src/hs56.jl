function hs56_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> -x[1] * x[2] * x[3],
        [
            1.0,
            1.0,
            1.0,
            asin(sqrt(1 / 4.2)),
            asin(sqrt(1 / 4.2)),
            asin(sqrt(1 / 4.2)),
            asin(sqrt(5 / 7.2)),
        ],
        x -> [
            x[1] - 4.2 * sin(x[4])^2
            x[2] - 4.2 * sin(x[5])^2
            x[3] - 4.2 * sin(x[6])^2
            x[1] + 2 * x[2] + 2 * x[3] - 7.2 * sin(x[7])^2
        ],
        zeros(4),
        zeros(4),
        name = "hs56_radnlp",
    )
end

function hs56_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    return ADNLPModel(
        x -> -x[1] * x[2] * x[3],
        [
            1.0,
            1.0,
            1.0,
            asin(sqrt(1 / 4.2)),
            asin(sqrt(1 / 4.2)),
            asin(sqrt(1 / 4.2)),
            asin(sqrt(5 / 7.2)),
        ],
        x -> [
            x[1] - 4.2 * sin(x[4])^2
            x[2] - 4.2 * sin(x[5])^2
            x[3] - 4.2 * sin(x[6])^2
            x[1] + 2 * x[2] + 2 * x[3] - 7.2 * sin(x[7])^2
        ],
        zeros(4),
        zeros(4),
        name = "hs56_autodiff",
        kwargs...,
    )
end
