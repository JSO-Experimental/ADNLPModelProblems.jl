using ADNLPModelProblems

using Suppressor, Test

@suppress begin
  n = 31
  for pb in ADNLPModelProblems.problems
      eval(Meta.parse("ADNLPModelProblems.$(pb)_autodiff(n=$n)"))
      eval(Meta.parse("ADNLPModelProblems.$(pb)_reverse(n=$n)"))
      eval(Meta.parse("ADNLPModelProblems.$(pb)_zygote(n=$n)"))
      eval(Meta.parse("ADNLPModelProblems.$(pb)_jump(n=$n)"))
  end

  for pb in ADNLPModelProblems.problems_no_jump
      eval(Meta.parse("ADNLPModelProblems.$(pb)_autodiff(n=$n)"))
      eval(Meta.parse("ADNLPModelProblems.$(pb)_reverse(n=$n)"))
      eval(Meta.parse("ADNLPModelProblems.$(pb)_zygote(n=$n)"))
  end
end
