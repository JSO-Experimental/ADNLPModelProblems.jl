# ADNLPModelProblems

<!---
| **Documentation** | **CI** | **Coverage** | **Release** | **DOI** |
|:-----------------:|:------:|:------------:|:-----------:|:-------:|
| [![docs-stable][docs-stable-img]][docs-stable-url] [![docs-dev][docs-dev-img]][docs-dev-url] | [![build-ci][build-ci-img]][build-ci-url] | [![codecov][codecov-img]][codecov-url] | [![release][release-img]][release-url] | [![doi][doi-img]][doi-url] |
--->
| **CI** | **Coverage** | **Release** |
|:------:|:------------:|:-----------:|
| [![build-ci][build-ci-img]][build-ci-url] | [![codecov][codecov-img]][codecov-url] | [![release][release-img]][release-url] |

<!---[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg--->
<!---[docs-stable-url]: https://JuliaSmoothOptimizers.github.io/ADNLPModelProblems/stable--->
<!---[docs-dev-img]: https://img.shields.io/badge/docs-dev-purple.svg--->
<!---[docs-dev-url]: https://JuliaSmoothOptimizers.github.io/ADNLPModelProblems/dev--->
[build-ci-img]: https://github.com/tmigot/ADNLPModelProblems/workflows/CI/badge.svg?branch=main
[build-ci-url]: https://github.com/tmigot/ADNLPModelProblems/actions
[codecov-img]: https://codecov.io/gh/tmigot/ADNLPModelProblems/branch/main/graph/badge.svg
[codecov-url]: https://codecov.io/gh/tmigot/ADNLPModelProblems
<!---[release-img]: https://img.shields.io/github/v/release/JuliaSmoothOptimizers/ADNLPModelProblems.svg?style=flat-square--->
<!---[release-url]: https://github.com/JuliaSmoothOptimizers/ADNLPModelProblems/releases--->
[release-img]: https://www.repostatus.org/badges/latest/wip.svg
[release-url]: https://www.repostatus.org/#wip
<!---[doi-img]: https://zenodo.org/badge/DOI/10.5281/zenodo.5056629.svg--->
<!---[doi-url]: https://doi.org/10.5281/zenodo.5056629--->

A list of optimization problems in ADNLPModel format.

The list of available problems are given in `String` format in
```
ADNLPModelProblems.problems
```
or
```
ADNLPModelProblems.problems_no_jump # for problems not available in JuMP format
```

As shown in the [`runtests.jl`](https://github.com/tmigot/ADNLPModelProblems/main/test/runtests.jl) there are several ways to access the problems:
```
eval(Meta.parse("ADNLPModelProblems.$(pb)_forward()")) # ForwardDiff backend
eval(Meta.parse("ADNLPModelProblems.$(pb)_reverse()")) # ReverseDiff backend
eval(Meta.parse("ADNLPModelProblems.$(pb)_zygote()")) # Zygote backend
eval(Meta.parse("ADNLPModelProblems.$(pb)_jump()")) # NLPModelJuMP model
```
and the default using `ADNLPModels.jl` default backend
```
eval(Meta.parse("ADNLPModelProblems.$(pb)_autodiff()"))
```

Properties of each problems can be accessed via
- `nameoftheproblem_meta`: Dict that contains main information. All these information are sum up in for the whole test set in the variables `ADNLPModelProblems.meta`.
- `get_nameoftheproblem_meta(n)`: returns the number of variables and constraints of the problem parametrized by `n`. 
If the problem is scalable this varies from `nameoftheproblem_meta[:nvar]` and `nameoftheproblem_meta[:ncon]` that were generated with `n = ADNLPModelProblems.default_nvar`.

# A list of problems

problems4 = ["clnlbeam", "controlinvestment", "hovercraft1d", "polygon1", "polygon2", "polygon3"]

... we should definitely try to add.

* Rocket control: https://jump.dev/JuMP.jl/stable/tutorials/Nonlinear%20programs/rocket_control/
* Space Shuttle Reentry Trajectory: https://jump.dev/JuMP.jl/stable/tutorials/Nonlinear%20programs/space_shuttle_reentry_trajectory/

* A lot of problems there: https://laurentlessard.com/teaching/524-intro-to-optimization/

* Bundle adjustement: https://grail.cs.washington.edu/projects/bal/ladybug.html
Those are not scalable, but pretty large.