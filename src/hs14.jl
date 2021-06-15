function hs14_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    adbackend = ADNLPModels.ForwardDiffAD(),
) where {T}

    x0 = T[2; 2]
    f(x) = (x[1] - 2)^2 + (x[2] - 1)^2
    c(x) = T[x[1] - 2 * x[2] + 1; -x[1]^2 / 4 - x[2]^2 + 1]
    lcon = T[0; 0]
    ucon = T[0; Inf]

    return ADNLPModel(f, x0, c, lcon, ucon, name = "hs14_autodiff", adbackend = adbackend)
end
