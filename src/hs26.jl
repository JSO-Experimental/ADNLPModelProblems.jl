function hs26_radnlp(; n::Int=100, type::Val{T}=Val(Float64), kwargs...) where T
  return RADNLPModel(
    x->(x[1] - x[2])^2 + (x[2] - x[3])^4, 
    [-2.6,  2.0,  2.0],
    x->[(1 + x[2]^2) * x[1] + x[3]^4 - 3], [0.0], [0.0],
    name = "hs26_radnlp"
  )
end

function hs26_autodiff(; n::Int=100, type::Val{T}=Val(Float64), adbackend=ADNLPModels.ForwardDiffAD()) where T
  return ADNLPModel(
    x->(x[1] - x[2])^2 + (x[2] - x[3])^4, 
    [-2.6,  2.0,  2.0],
    x->[(1 + x[2]^2) * x[1] + x[3]^4 - 3], [0.0], [0.0],
    name = "hs26_autodiff", adbackend=adbackend
  )
end
