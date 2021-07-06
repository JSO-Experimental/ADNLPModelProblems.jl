module ADNLPModelProblems

#This package
using ADNLPModels, ReverseDiff, Zygote, ForwardDiff
# Temp
using NLPModels, NLPModelsJuMP, JuMP, OptimizationProblems
#stdlib
using DataFrames, LinearAlgebra

problems2 = [
    "arglina",
    "arglinb",
    "arglinc",
    "arwhead",
    "bdqrtic",
    "beale",
    "broydn7d",
    "brownden",
    "brybnd",
    "chainwoo",
    "chnrosnb_mod",
    "cosine",
    "cragglvy",
    "curly10",
    "curly20",
    "curly30",
    "dixon3dq",
    "dqdrtic",
    "dqrtic",
    "edensch",
    "eg2",
    "engval1",
    "errinros_mod",
    "extrosnb",
    "fletcbv2",
    "fletcbv3_mod",
    "fletchcr",
    "freuroth",
    "genhumps",
    "genrose",
    "genrose_nash",
    "indef_mod",
    "liarwhd",
    "morebv",
    "ncb20",
    "ncb20b",
    "noncvxu2",
    "noncvxun",
    "nondia",
    "nondquar",
    "NZF1",
    "penalty2",
    "penalty3",
    "powellsg",
    "power",
    "quartc",
    "sbrybnd",
    "schmvett",
    "scosine",
    "sparsine",
    "sparsqur",
    "srosenbr",
    "sinquad",
    "tointgss",
    "tquartic",
    "tridia",
    "vardim",
    "woods",
]
# problems with constraints (none are scalable)
problems3 = [
    "hs5",
    "hs6",
    "hs7",
    "hs8",
    "hs9",
    "hs10",
    "hs11",
    "hs14",
    "hs26",
    "hs27",
    "hs28",
    "hs39",
    "hs40",
    "hs42",
    "hs46",
    "hs47",
    "hs48",
    "hs49",
    "hs50",
    "hs51",
    "hs52",
    "hs56",
    "hs63",
    "hs77",
    "hs79",
]
#scalable constrained problems
const scalable_cons_problems =
    ["clnlbeam", "controlinvestment", "hovercraft1d", "polygon1", "polygon2", "polygon3"]
# error with "structural" ?

const problems = union(problems2, problems3, scalable_cons_problems)

# Test problems from ADNLPModels: no JuMP models for these
const problems_no_jump = ["lincon", "linsv", "mgh01feas"]

path = dirname(@__FILE__)
files = filter(x -> x[end-2:end] == ".jl", readdir(path))
for file in files
    if file ≠ "ADNLPModelProblems.jl"
        include(file)
    end
end
#=
for pb in union(problems, problems_no_jump)
    include("$(lowercase(pb)).jl")
end
=#

const default_nvar = 100 # default parameter for scalable problems

const objtypes = [:none, :constant, :linear, :quadratic, :sum_of_squares, :other]
const contypes = [:unconstrained, :linear, :quadratic, :general]
const origins = [:academic, :modelling, :real, :unknown]
const cqs = Dict(4 => "LICQ", 3 => "MFCQ", 2 => "GCQ", 1 => "none", 0 => "unknown")

const names = [
    :nvar
    :variable_size
    :ncon
    :variable_con_size
    :nnzo
    :nnzh
    :nnzj
    :minimize
    :name
    :optimal_value
    :has_multiple_solution
    :is_infeasible
    :objtype
    :contype
    :origin
    :deriv
    :not_everywhere_defined
    :has_cvx_obj
    :has_cvx_con
    :has_equalities_only
    :has_inequalities_only
    :has_bounds
    :has_fixed_variables
    :cqs
]

const types = [
    Int
    Bool
    Int
    Bool
    Int
    Int
    Int
    Bool
    String
    Real
    Union{Bool,Missing}
    Union{Bool,Missing}
    Symbol
    Symbol
    Symbol
    UInt8
    Union{Bool,Missing}
    Bool
    Bool
    Bool
    Bool
    Bool
    Bool
    UInt8
]

const number_of_problems = length(files)

"""
    OptimizationProblems.meta
A composite type that represents the main features of the optimization problem.
    optimize    obj(x)
    subject to  lvar ≤    x    ≤ uvar
                lcon ≤ cons(x) ≤ ucon
---
The following keys are valid:
Problem meta
- `nvar`: number of general constraints
- `variable_size`: true if we can modify problem size
- `ncon`: number of general constraints
- `variable_con_size`: true if we can modify problem size
- `nnzo`: number of nonzeros in all objectives gradients
- `nnzh`: number of elements needed to store the nonzeros in the sparse Hessian
- `nnzj`: number of elements needed to store the nonzeros in the sparse Jacobian
- `minimize`: true if optimize == minimize
- `name`: problem name
Solution meta
- `optimalvalue`: best known objective value (NaN if unknown, -Inf if unbounded problem)
- `has_multiple_solution`: true if the problem has more than one global solution
- `is_infeasible`: true if problem is infeasible
Classification
- `objtype`: #in objtypes
- `contype`: #in contypes
- `origin`: #in origins
- `deriv`: UInt8 with the largest order derivatives available
- `not_everywhere_defined`: true if the problem might return NaN or Inf outside the bounds
- `has_cvx_obj`: true if the problem has a convex objective
- `has_cvx_con`: true if the problem has convex constraints
- `has_equalities_only`: true if the problem constraints are equality constraints (doesn't include bounds)
- `has_inequalities_only`: true if the problem constraints are inequality constraints (doesn't include bounds)
- `has_bounds`: true if the problem has bound constraints
- `has_fixed_variables`: true if it has fixed variables
- `cqs`: Between 0 and 4 indicates the constraint qualification of the problem, see `cqs(i)` for the correspondance.
"""
const meta = DataFrame(names .=> [Array{T}(undef, number_of_problems) for T in types])

"""
  `generate_meta(jmodel, name, variable_size, variable_con_size, cvx_obj, cvx_con, quad_cons)`   
  `generate_meta(name, variable_size, variable_con_size, cvx_obj, cvx_con, quad_cons)`   
  is used to generate the meta of a given JuMP model.
"""
function generate_meta(name::String, args...; kwargs...)
    return generate_meta(
        eval(Meta.parse(name * "_autodiff(n=$(default_nvar))")),
        name,
        args...;
        kwargs...,
    )
end

function generate_meta(
    nlp::AbstractNLPModel,
    name::String;
    variable_size::Bool = false,
    variable_con_size::Bool = false,
    cvx_obj::Bool = false,
    cvx_con::Bool = false,
    origin::Symbol = :unknown,
    quad_cons::Bool = false,
    cq::UInt8 = UInt8(0),
)
    contype = if quad_cons
        :quadratic
    elseif nlp.meta.ncon == 0 && !(length(nlp.meta.ifree) < nlp.meta.nvar)
        :unconstrained
    elseif nlp.meta.nlin == nlp.meta.ncon > 0
        :linear
    else
        :general
    end
    objtype = :other

    str = "$(name)_meta = Dict(
      :nvar => $(nlp.meta.nvar),
      :variable_size => $(variable_size),
      :ncon => $(nlp.meta.ncon),
      :variable_con_size => $(variable_con_size),
      :nnzo => $(nlp.meta.nnzo),
      :nnzh => $(nlp.meta.nnzh),
      :nnzj => $(nlp.meta.nnzj),
      :minimize => $(nlp.meta.minimize),
      :name => \"$(name)\",
      :optimal_value => $(NaN),
      :has_multiple_solution => $(missing),
      :is_infeasible => $(nlp.meta.ncon == 0 ? false : missing),
      :objtype => :$(objtype),  
      :contype => :$(contype),
      :origin => :$(origin),
      :deriv => typemax(UInt8),
      :not_everywhere_defined => $(missing),
      :has_cvx_obj => $(cvx_obj),
      :has_cvx_con => $(cvx_con),
      :has_equalities_only => $(length(nlp.meta.jfix) == nlp.meta.ncon > 0),
      :has_inequalities_only => $(nlp.meta.ncon > 0 && length(nlp.meta.jfix) == 0),
      :has_bounds => $(length(nlp.meta.ifree) < nlp.meta.nvar),
      :has_fixed_variables => $(nlp.meta.ifix != []),
      :cqs => $(cq),
    )"
    return str
end

let i=1
  for pb in union(problems, problems_no_jump)
    # eval(Meta.parse("$(pb)_radnlp_smartreverse(args... ; kwargs...) = $(pb)_radnlp(args... ; n=$(nvar), gradient = ADNLPModels.smart_reverse, kwargs...)"))
    meta[i,:] = eval(Meta.parse(pb * "_meta"))
    nvar, ncon = meta[i, :nvar], meta[i, :ncon]
    eval(
      Meta.parse(
        "$(pb)_reverse(args... ; n=$(default_nvar), kwargs...) = $(pb)_autodiff(args... ; adbackend=ADNLPModels.ReverseDiffAD($(nvar),$(ncon)), n=n, kwargs...)",
      ),
    )
    eval(
      Meta.parse(
        "$(pb)_zygote(args... ; n=$(default_nvar), kwargs...) = $(pb)_autodiff(args... ; adbackend=ADNLPModels.ZygoteAD($(nvar),$(ncon)), n=n, kwargs...)",
      ),
    )
    if pb in problems
      eval(
        Meta.parse(
          "$(pb)_jump(args... ; n=$(default_nvar), kwargs...) = MathOptNLPModel($(pb)(n))",
        ),
      )
    end
end

end # module
