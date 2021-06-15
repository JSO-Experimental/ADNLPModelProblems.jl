module ADNLPModelProblems

  #This package
  using ADNLPModels, ReverseDiff, Zygote, ForwardDiff
  # Temp
  using NLPModelsJuMP, JuMP, OptimizationProblems
  #stdlib
  using LinearAlgebra

  problems2 = ["arglina", "arglinb", "arglinc", "arwhead", "bdqrtic", "beale", "broydn7d",
              "brownden", "brybnd", "chainwoo", "chnrosnb_mod", "cosine", "cragglvy", "curly10", "curly20", 
              "curly30", "dixon3dq", "dqdrtic",
              "dqrtic", "edensch", "eg2", "engval1", "errinros_mod", "extrosnb", "fletcbv2",
              "fletcbv3_mod", "fletchcr", "freuroth", "genhumps", "genrose", "genrose_nash",
              "indef_mod", "liarwhd", "morebv", "ncb20", "ncb20b", "noncvxu2", "noncvxun",
              "nondia", "nondquar", "NZF1", "penalty2", "penalty3", "powellsg", "power",
              "quartc", "sbrybnd", "schmvett", "scosine", "sparsine", "sparsqur", "srosenbr",
              "sinquad", "tointgss", "tquartic", "tridia", "vardim", "woods"]
  # problems with constraints (none are scalable)
  problems3 = ["hs5", "hs6", "hs7", "hs8", "hs9", "hs10", "hs11", "hs14", "hs26", "hs27", "hs28", "hs39", "hs40", "hs42", "hs46",
              "hs47", "hs48", "hs49", "hs50", "hs51", "hs52", "hs56", "hs63", "hs77", "hs79"]
  #scalable constrained problems
  problems4 = ["clnlbeam", "controlinvestment", "hovercraft1d", "polygon1", "polygon2", "polygon3"]
  # error with "structural" ?

  const problems = union(problems2, problems3, problems4)

  # Test problems from ADNLPModels: no JuMP models for these
  const problems_no_jump = ["lincon", "linsv", "mgh01feas"]

  for pb in union(problems, problems_no_jump)
    include("$(lowercase(pb)).jl")
  end

  nvar = 100 # default parameter for scalable problems
  for pb in union(problems, problems_no_jump)
    # eval(Meta.parse("$(pb)_radnlp_smartreverse(args... ; kwargs...) = $(pb)_radnlp(args... ; n=$(nvar), gradient = ADNLPModels.smart_reverse, kwargs...)"))
    eval(Meta.parse("$(pb)_reverse(args... ; kwargs...) = $(pb)_autodiff(args... ; adbackend=ADNLPModels.ReverseDiffAD(), n=$(nvar), kwargs...)"))
    eval(Meta.parse("$(pb)_zygote(args... ; kwargs...) = $(pb)_autodiff(args... ; adbackend=ADNLPModels.ZygoteAD(), n=$(nvar), kwargs...)"))
    if pb in problems
      eval(Meta.parse("$(pb)_jump(args... ; n=$(nvar), kwargs...) = MathOptNLPModel($(pb)(n))"))
    end
  end

end # module
