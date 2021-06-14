function hs28_radnlp(; n::Int=100, type::Val{T}=Val(Float64), kwargs...) where T
  return RADNLPModel(
    x->(x[1] + x[2])^2 + (x[2]+x[3])^2, 
    [-4.0, 1.0, 1.0],
    x->[x[1] + 2*x[2] + 3*x[3] - 1], [0.0], [0.0],
    name = "hs28_radnlp"
  )
end

function hs28_autodiff(; n::Int=100, type::Val{T}=Val(Float64), adbackend=ADNLPModels.ForwardDiffAD()) where T
  return ADNLPModel(
    x->(x[1] + x[2])^2 + (x[2]+x[3])^2, 
    [-4.0, 1.0, 1.0],
    x->[x[1] + 2*x[2] + 3*x[3] - 1], [0.0], [0.0],
    name = "hs28_autodiff", adbackend=adbackend
  )
end
