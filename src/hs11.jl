function hs11_autodiff(; n::Int=100, type::Val{T}=Val(Float64), adbackend=ADNLPModels.ForwardDiffAD()) where T

  x0 = T[4.9; 0.1]
  f(x) = (x[1] - 5)^2 + x[2]^2 - 25
  c(x) = T[-x[1]^2 + x[2]]
  lcon = T[-Inf]
  ucon = T[0.0]

  return ADNLPModel(f, x0, c, lcon, ucon, name="hs11_autodiff", adbackend=adbackend)

end