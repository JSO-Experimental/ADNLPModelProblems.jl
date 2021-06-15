function hs10_autodiff(; n::Int=100, type::Val{T}=Val(Float64), adbackend=ADNLPModels.ForwardDiffAD()) where T

  x0 = T[-10; 10]
  f(x) = x[1] - x[2]
  c(x) = T[-3 * x[1]^2 + 2 * x[1] * x[2] - x[2]^2 + 1]
  lcon = T[0.0]
  ucon = T[Inf]

  return ADNLPModel(f, x0, c, lcon, ucon, name="hs10_autodiff", adbackend=adbackend)
end
