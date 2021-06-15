# ADNLPModelProblems
A list of optimization problems in ADNLPModel format.

The list of available problems are given in `String` format in
```
ADNLPModelProblems.problems
```
or
```
ADNLPModelProblems.problems_no_jump # for problems not available in JuMP format
```

As shown in the `runtests.jl` there are several ways to access the problems:
```
eval(Meta.parse("ADNLPModelProblems.$(pb)_autodiff()")) # ForwardDiff backend
eval(Meta.parse("ADNLPModelProblems.$(pb)_reverse()")) # ReverseDiff backend
eval(Meta.parse("ADNLPModelProblems.$(pb)_zygote()")) # Zygote backend
eval(Meta.parse("ADNLPModelProblems.$(pb)_jump()")) # NLPModelJuMP model
```
