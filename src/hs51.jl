function hs51_radnlp(; n::Int=100, type::Val{T}=Val(Float64), kwargs...) where T
  return RADNLPModel(
    x->(x[1] - x[2])^2 + (x[2] + x[3] - 2)^2 + (x[4] - 1)^2 + (x[5] - 1)^2, 
    [2.5, 0.5, 2.0, -1.0, 0.5],
    x->[x[1] + 3*x[2] - 4; x[3] + x[4] - 2*x[5]; x[2] - x[5]], zeros(3), zeros(3),
    name = "hs51_radnlp"
  )
end

function hs51_autodiff(; n::Int=100, type::Val{T}=Val(Float64), adbackend=ADNLPModels.ForwardDiffAD()) where T
  return ADNLPModel(
    x->(x[1] - x[2])^2 + (x[2] + x[3] - 2)^2 + (x[4] - 1)^2 + (x[5] - 1)^2, 
    [2.5, 0.5, 2.0, -1.0, 0.5],
    x->[x[1] + 3*x[2] - 4; x[3] + x[4] - 2*x[5]; x[2] - x[5]], zeros(3), zeros(3),
    name = "hs51_autodiff", adbackend=adbackend
  )
end
