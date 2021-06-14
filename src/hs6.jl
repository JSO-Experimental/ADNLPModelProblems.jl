function hs6_radnlp(; n::Int=100, type::Val{T}=Val(Float64), kwargs...) where T
  return RADNLPModel(
    x -> (x[1] - 1)^2, 
    [-1.2; 1.0], 
    x -> [10 * (x[2] - x[1]^2)], 
    zeros(1), zeros(1), 
    name = "hs6_radnlp"
  )
end

function hs6_autodiff(; n::Int=100, type::Val{T}=Val(Float64), adbackend=ADNLPModels.ForwardDiffAD()) where T
  return ADNLPModel(
    x -> (x[1] - 1)^2, 
    [-1.2; 1.0], 
    x -> [10 * (x[2] - x[1]^2)], 
    zeros(1), zeros(1), adbackend=adbackend, 
    name = "hs6_autodiff"
  )
end
