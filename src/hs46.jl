function hs46_radnlp(; n::Int=100, type::Val{T}=Val(Float64), kwargs...) where T
  return RADNLPModel(
    x->(x[1] - x[2])^2 + (x[3] - 1)^2 + (x[4] - 1)^4 + (x[5] - 1)^6, 
    [sqrt(2)/2, 1.75, 0.5, 2.0, 2.0],
    x->[(x[1]^2)*x[4] + sin(x[4] - x[5]) - 1; x[2] + (x[3]^4)*(x[4]^2) - 2], zeros(2), zeros(2),
    name = "hs46_radnlp"
  )
end

function hs46_autodiff(; n::Int=100, type::Val{T}=Val(Float64), adbackend=ADNLPModels.ForwardDiffAD()) where T
  return ADNLPModel(
    x->(x[1] - x[2])^2 + (x[3] - 1)^2 + (x[4] - 1)^4 + (x[5] - 1)^6, 
    [sqrt(2)/2, 1.75, 0.5, 2.0, 2.0],
    x->[(x[1]^2)*x[4] + sin(x[4] - x[5]) - 1; x[2] + (x[3]^4)*(x[4]^2) - 2], zeros(2), zeros(2),
    name = "hs46_autodiff", adbackend=adbackend
  )
end
