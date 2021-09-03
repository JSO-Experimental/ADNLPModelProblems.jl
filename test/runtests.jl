using ADNLPModelProblems

using Suppressor, Test

@suppress begin
  for pb in ADNLPModelProblems.problems
    n = ADNLPModelProblems.default_nvar
    eval(Meta.parse("ADNLPModelProblems.$(pb)_autodiff(n=$n)"))
    eval(Meta.parse("ADNLPModelProblems.$(pb)_forward(n=$n)"))
    eval(Meta.parse("ADNLPModelProblems.$(pb)_reverse(n=$n)"))
    eval(Meta.parse("ADNLPModelProblems.$(pb)_zygote(n=$n)"))
    if !(pb in ADNLPModelProblems.problems_no_jump)
      eval(Meta.parse("ADNLPModelProblems.$(pb)_jump(n=$n)"))
    end

    n, m = eval(
      Meta.parse("ADNLPModelProblems.get_$(pb)_meta(n=$(2 * ADNLPModelProblems.default_nvar))"),
    )
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
end
