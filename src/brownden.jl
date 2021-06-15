function brownden_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    adbackend = ADNLPModels.ForwardDiffAD(),
) where {T}

    x0 = T[25.0; 5.0; -5.0; -1.0]
    f(x) = begin
        s = zero(T)
        for i = 1:20
            s +=
                (
                    (x[1] + x[2] * T(i) / 5 - exp(T(i) / 5))^2 +
                    (x[3] + x[4] * sin(T(i) / 5) - cos(T(i) / 5))^2
                )^2
        end
        return s
    end

    return ADNLPModel(f, x0, name = "brownden_autodiff", adbackend = adbackend)
end
