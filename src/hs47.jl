function hs47_radnlp(; n::Int=100, type::Val{T}=Val(Float64), kwargs...) where T
  return RADNLPModel(
    x->(x[1] - x[2])^2 + (x[2] - x[3])^3 + (x[3] - x[4])^4 + (x[4] - x[5])^4, 
    [35.0,-31.0,11.0,5.0,-5.0],
    x->[x[1] + x[2]^2 + x[3]^3 - 3; x[2] - x[3]^2 + x[4] - 1; x[1]*x[5] - 1], zeros(3), zeros(3),
    name = "hs47_radnlp"
  )
end

function hs47_autodiff(; n::Int=100, type::Val{T}=Val(Float64), adbackend=ADNLPModels.ForwardDiffAD()) where T
  return ADNLPModel(
    x->(x[1] - x[2])^2 + (x[2] - x[3])^3 + (x[3] - x[4])^4 + (x[4] - x[5])^4, 
    [35.0,-31.0,11.0,5.0,-5.0],
    x->[x[1] + x[2]^2 + x[3]^3 - 3; x[2] - x[3]^2 + x[4] - 1; x[1]*x[5] - 1], zeros(3), zeros(3),
    name = "hs47_autodiff", adbackend=adbackend
  )
end
