#=
https://nbviewer.jupyter.org/urls/laurentlessard.com/teaching/cs524/examples/Hover%201D.ipynb

Hovercraft 1D example
=#

function hovercraft1d(args...; n::Int = default_nvar, kwargs...)
  m = Model()

  T = div(n, 3)           # length of time horizon
  @variable(m, x[1:T])    # resulting position
  @variable(m, v[1:T])    # resulting velocity
  @variable(m, u[1:(T - 1)])  # thruster input

  # constraint on start and end positions and velocities
  @constraint(m, x[1] == 0)
  @constraint(m, v[1] == 0)
  @constraint(m, x[T] == 100)
  @constraint(m, v[T] == 0)

  # satisfy the dynamics
  for i = 1:(T - 1)
    @constraint(m, x[i + 1] == x[i] + v[i])
    @constraint(m, v[i + 1] == v[i] + u[i])
  end

  # minimize 2-norm
  @objective(m, Min, sum(u .^ 2))
  return m
end

function hovercraft1d_autodiff(
  args...;
  n::Int = 200,
  type::Val{T} = Val(Float64),
  kwargs...,
) where {T}
  N = div(n, 3)
  function f(y)
    x, v, u = y[1:N], y[(N + 1):(2 * N)], y[(2 * N + 1):end]
    return sum(u .^ 2)
  end
  function c(y)
    x, v, u = y[1:N], y[(N + 1):(2 * N)], y[(2 * N + 1):end]
    return vcat(
      x[1],
      v[1],
      x[N] - 100,
      v[N],
      [x[i + 1] - x[i] - v[i] for i = 1:(N - 1)],
      [v[i + 1] - v[i] - u[i] for i = 1:(N - 1)],
    )
  end
  xi = zeros(T, 3 * N - 1)
  return ADNLPModel(
    f,
    xi,
    c,
    zeros(T, 2 * N + 2),
    zeros(T, 2 * N + 2),
    name = "hovercraft1d_autodiff";
    kwargs...,
  )
end

hovercraft1d_meta = Dict(
  :nvar => 3 * div(default_nvar, 3) - 1,
  :variable_size => true,
  :ncon => 2 * div(default_nvar, 3) + 2,
  :variable_con_size => true,
  :nnzo => 98,
  :nnzh => 4851,
  :nnzj => 6664,
  :minimize => true,
  :name => "hovercraft1d",
  :optimal_value => NaN,
  :has_multiple_solution => missing,
  :is_infeasible => missing,
  :objtype => :sum_of_squares,
  :contype => :linear,
  :origin => :unknown,
  :deriv => typemax(UInt8),
  :not_everywhere_defined => false,
  :has_cvx_obj => false,
  :has_cvx_con => false,
  :has_equalities_only => true,
  :has_inequalities_only => false,
  :has_bounds => false,
  :has_fixed_variables => false,
  :cqs => 0,
)

get_hovercraft1d_meta(; n::Integer = default_nvar) = (3 * div(n, 3) - 1, 2 * div(n, 3) + 2)
