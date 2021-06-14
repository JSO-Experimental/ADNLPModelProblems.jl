function hs63_radnlp(; n::Int=100, type::Val{T}=Val(Float64), kwargs...) where T
  return RADNLPModel(
    x->1000 - x[1]^2 - 2*x[2]^2 - x[3]^2 - x[1]*x[2] - x[1]*x[3], 
    2ones(T, 3),
    x->[8*x[1]   + 14*x[2] + 7*x[3] - 56; x[1]^2 + x[2]^2  + x[3]^2 - 25], zeros(2), zeros(2),
    name = "hs63_radnlp"
  )
end

function hs63_autodiff(; n::Int=100, type::Val{T}=Val(Float64), adbackend=ADNLPModels.ForwardDiffAD()) where T
  return ADNLPModel(
    x->1000 - x[1]^2 - 2*x[2]^2 - x[3]^2 - x[1]*x[2] - x[1]*x[3], 
    2ones(T, 3),
    x->[8*x[1]   + 14*x[2] + 7*x[3] - 56; x[1]^2 + x[2]^2  + x[3]^2 - 25], zeros(2), zeros(2),
    name = "hs63_autodiff", adbackend=adbackend
  )
end
