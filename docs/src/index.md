# ADNLPModelProblems

A list of optimization problems in `ADNLPModel` format, see[ADNLPModels.jl](https://github.com/JuliaSmoothOptimizers/ADNLPModels.jl). Most of the problems given here are also available in [JuMP](https://jump.dev/JuMP.jl/stable/) format either in [OptimizationProblems.jl](https://github.com/JuliaSmoothOptimizers/OptimizationProblems.jl/) or within this package.

# How to contribute?

Contributions with new problems are very welcome. A couple of advice for a successful contribution:
- check that the new problem is not already on the list.
- furnish as much detail as possible regarding the origin of the problem, e.g. citation, link, application ...
- the problem should be type-stable, i.e. argument `type::Val{T} = Val(Float64)` should induce the type returned by the `ADNLPModel`.
- fill-in the `meta` as precisely as possible. The function `generate_meta` helps for this step.

# Available constants/functions

The list of available problems are given in `String` format in
```
ADNLPModelProblems.problems
```
This list includes unconstrained and constrained problems, and several are scalable problems. The default parameter value for the variable scale is:
```
ADNLPModelProblems.default_nvar
```
The list of problems for which there is no JuMP model is obtained by:
```
ADNLPModelProblems.problems_no_jump
```

There are several ways to access the problems, for instance `"power"`:
```
ADNLPModelProblems.power_forward() # ForwardDiff backend
ADNLPModelProblems.power_reverse() # ReverseDiff backend
ADNLPModelProblems.power_zygote() # Zygote backend
ADNLPModelProblems.power_jump() # NLPModelJuMP model
```
and using `ADNLPModels.jl` default backend
```
ADNLPModelProblems.power_autodiff()
```
We refer to the documentation in [ADNLPModels.jl](https://github.com/JuliaSmoothOptimizers/ADNLPModels.jl) for more information on the `ADBackend` and the default usage.

Finally, the properties of each problem can be accessed via
- `power_meta`: Dict that contains main information. This information is summed up for the whole test set in the variables `ADNLPModelProblems.meta`.
- `power_meta(n)`: returns the number of variables and constraints of the problem parameterized by `n`. 
If the problem is scalable this varies from `power_meta[:nvar]` and `power_meta[:ncon]` that were generated with `n = ADNLPModelProblems.default_nvar`.
