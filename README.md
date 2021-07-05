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

# A list of problems

problems4 = ["clnlbeam", "controlinvestment", "hovercraft1d", "polygon1", "polygon2", "polygon3"]

... we should definitely try to add.

* Rocket control: https://jump.dev/JuMP.jl/stable/tutorials/Nonlinear%20programs/rocket_control/
* Space Shuttle Reentry Trajectory: https://jump.dev/JuMP.jl/stable/tutorials/Nonlinear%20programs/space_shuttle_reentry_trajectory/

* A lot of problems there: https://laurentlessard.com/teaching/524-intro-to-optimization/

* Bundle adjustement: https://grail.cs.washington.edu/projects/bal/ladybug.html
Those are not scalable, but pretty large.