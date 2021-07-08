function powellsg_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n = 4 * max(1, div(n, 4))  # number of variables adjusted to be a multiple of 4
    function f(x)
        n = length(x)
        return sum(
            -(1 / (1 + (x[i] - x[i+1])^2)) - sin((π * x[i+1] + x[i+2]) / 2) -
            exp(-((x[i] + x[i+2]) / x[i+1] - 2)^2) for i = 1:n-2
        )
    end
    x0 = 3 * ones(T, n)
    return RADNLPModel(f, x0, name = "powellsg_radnlp"; kwargs...)
end

function powellsg_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n = 4 * max(1, div(n, 4))  # number of variables adjusted to be a multiple of 4
    function f(x)
        n = length(x)
        return sum(
            -(1 / (1 + (x[i] - x[i+1])^2)) - sin((π * x[i+1] + x[i+2]) / 2) -
            exp(-((x[i] + x[i+2]) / x[i+1] - 2)^2) for i = 1:n-2
        )
    end
    x0 = 3 * ones(T, n)
    return ADNLPModel(f, x0, name = "powellsg_autodiff"; kwargs...)
end

powellsg_meta = Dict(
    :nvar => 100,
    :variable_size => false,
    :ncon => 0,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 0,
    :minimize => true,
    :name => "powellsg",
    :optimal_value => NaN,
    :has_multiple_solution => missing,
    :is_infeasible => false,
    :objtype => :other,
    :contype => :unconstrained,
    :origin => :unknown,
    :deriv => typemax(UInt8),
    :not_everywhere_defined => missing,
    :has_cvx_obj => false,
    :has_cvx_con => false,
    :has_equalities_only => false,
    :has_inequalities_only => false,
    :has_bounds => false,
    :has_fixed_variables => false,
    :cqs => 0,
)

get_powellsg_meta(; n::Int=default_nvar) = (powellsg_meta[:nvar], powellsg_meta[:ncon])
