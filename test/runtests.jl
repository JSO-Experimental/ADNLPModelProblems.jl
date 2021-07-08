using ADNLPModelProblems

using Suppressor, Test

@suppress begin
    n = ADNLPModelProblems.default_nvar
    for pb in ADNLPModelProblems.problems
        @show pb
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

for pb in union(ADNLPModelProblems.problems, ADNLPModelProblems.problems_no_jump)
  n, m = eval(Meta.parse("ADNLPModelProblems.get_$(pb)_meta(n=$(2 * ADNLPModelProblems.default_nvar))"))
  meta_pb = eval(Meta.parse("ADNLPModelProblems.$(pb)_meta"))
  if meta_pb[:variable_size]
    @test n != meta_pb[:nvar]
  else
    @test n == meta_pb[:nvar]
  end
  if meta_pb[:variable_con_size]
    @test m != meta_pb[:ncon]
  else
    @test m == meta_pb[:ncon]
  end
end