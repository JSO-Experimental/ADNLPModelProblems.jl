using ADNLPModelProblems, NLPModels

function check_x_feasibility(nlp, x)
  if nlp.meta.ncon > 0
    cx = cons(nlp, x)
    vio = minimum(min.(-cx + nlp.meta.ucon, cx - nlp.meta.lcon, 0))
    vio_bounds = minimum(min.(-x + nlp.meta.uvar, x - nlp.meta.lvar, 0))
    if vio < 0 && vio_bounds < 0
      @show "Infeasible x0"
      return false
    else
      @show "Feasible x0"
      return true
    end
  else
    @show "Feasible x0 (no con)"
    return true
  end
end

infeasible_pb = []
for pb in ADNLPModelProblems.problems
  @show pb
  n = ADNLPModelProblems.default_nvar
  nlp = eval(Meta.parse("ADNLPModelProblems.$(pb)_autodiff(n=$n)"))
  feas = check_x_feasibility(nlp, nlp.meta.x0)
  if !feas
    push!(infeasible_pb, pb)
  end
end

infeasible_pb
