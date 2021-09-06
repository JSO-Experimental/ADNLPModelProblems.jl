# ADNLPModelProblems.jl

<!---
| **Documentation** | **CI** | **Coverage** | **Release** | **DOI** |
|:-----------------:|:------:|:------------:|:-----------:|:-------:|
| [![docs-stable][docs-stable-img]][docs-stable-url] [![docs-dev][docs-dev-img]][docs-dev-url] | [![build-ci][build-ci-img]][build-ci-url] | [![codecov][codecov-img]][codecov-url] | [![release][release-img]][release-url] | [![doi][doi-img]][doi-url] |
--->
| **CI** | **Coverage** | **Release** |
|:------:|:------------:|:-----------:|
| [![build-ci][build-ci-img]][build-ci-url] | [![codecov][codecov-img]][codecov-url] | [![release][release-img]][release-url] |

<!---[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg--->
<!---[docs-stable-url]: https://JuliaSmoothOptimizers.github.io/ADNLPModelProblems.jl/stable--->
<!---[docs-dev-img]: https://img.shields.io/badge/docs-dev-purple.svg--->
<!---[docs-dev-url]: https://JuliaSmoothOptimizers.github.io/ADNLPModelProblems.jl/dev--->
[build-ci-img]: https://github.com/tmigot/ADNLPModelProblems.jl/workflows/CI/badge.svg?branch=main
[build-ci-url]: https://github.com/tmigot/ADNLPModelProblems.jl/actions
[codecov-img]: https://codecov.io/gh/tmigot/ADNLPModelProblems.jl/branch/main/graph/badge.svg
[codecov-url]: https://codecov.io/gh/tmigot/ADNLPModelProblems.jl
<!---[release-img]: https://img.shields.io/github/v/release/JuliaSmoothOptimizers/ADNLPModelProblems.jl.svg?style=flat-square--->
<!---[release-url]: https://github.com/JuliaSmoothOptimizers/ADNLPModelProblems.jl/releases--->
[release-img]: https://www.repostatus.org/badges/latest/wip.svg
[release-url]: https://www.repostatus.org/#wip
<!---[doi-img]: https://zenodo.org/badge/DOI/10.5281/zenodo.5056629.svg--->
<!---[doi-url]: https://doi.org/10.5281/zenodo.5056629--->

A list of optimization problems in `ADNLPModel` format, see [ADNLPModels.jl](https://github.com/JuliaSmoothOptimizers/ADNLPModels.jl). Most of the problems given here are also available in [JuMP](https://jump.dev/JuMP.jl/stable/) format either in [OptimizationProblems.jl](https://github.com/JuliaSmoothOptimizers/OptimizationProblems.jl/) or within this package.

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

Finally, the properties of each problem can be accessed via
- `$(nameoftheproblem)_meta`: Dict that contains main information. This information is summed up for the whole test set in the variables `ADNLPModelProblems.meta`.
- `get_$(nameoftheproblem)_meta(n)`: returns the number of variables and constraints of the problem parameterized by `n`. 
If the problem is scalable this varies from `$(nameoftheproblem)_meta[:nvar]` and `$(nameoftheproblem)_meta[:ncon]` that were generated with `n = ADNLPModelProblems.default_nvar`.

# How to contribute?

Contributions with new problems are very welcome. A couple of advice for a successful contribution:
- check that the new problem is not already on the list.
- furnish as much detail as possible regarding the origin of the problem, e.g. citation, link, application ...
- the problem should be type-stable, i.e. argument `type::Val{T} = Val(Float64)` should induce the type returned by the `ADNLPModel`.
- fill-in the `meta` as precisely as possible. The function `generate_meta` helps for this step.
