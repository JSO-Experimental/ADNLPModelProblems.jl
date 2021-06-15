function linsv_autodiff(; n::Int=100, type::Val{T}=Val(Float64), adbackend=ADNLPModels.ForwardDiffAD()) where T

  x0 = zeros(T, 2)
  f(x) = x[1]
  con(x) = T[x[1] + x[2]; x[2]]
  lcon = T[3; 1]
  ucon = T[Inf; Inf]

  return ADNLPModel(f, x0, con, lcon, ucon, name="linsv_autodiff", adbackend=adbackend)
end
