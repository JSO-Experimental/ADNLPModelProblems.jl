function ncb20b_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n ≥ 20 || error("ncb20 : n ≥ 20")
    function f(x)
        n = length(x)
        h = 1.0 / (n - 1)
        return sum(
            (10.0 / i) * (sum(x[i+j-1] / (1 + x[i+j-1]^2) for j = 1:20))^2 -
            0.2 * sum(x[i+j-1] for j = 1:20) for i = 1:n-19
        ) + sum(100.0 * x[i]^4 + 2.0 for i = 1:n)
    end
    x0 = zeros(T, n)
    return RADNLPModel(f, x0, name = "ncb20b_radnlp"; kwargs...)
end

function ncb20b_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    n ≥ 20 || error("ncb20 : n ≥ 20")
    function f(x)
        n = length(x)
        h = 1.0 / (n - 1)
        return sum(
            (10.0 / i) * (sum(x[i+j-1] / (1 + x[i+j-1]^2) for j = 1:20))^2 -
            0.2 * sum(x[i+j-1] for j = 1:20) for i = 1:n-19
        ) + sum(100.0 * x[i]^4 + 2.0 for i = 1:n)
    end
    x0 = zeros(T, n)
    return ADNLPModel(f, x0, name = "ncb20b_autodiff"; kwargs...)
end

ncb20b_meta = Dict(
    :nvar => 100,
    :variable_size => false,
    :ncon => 0,
    :variable_con_size => false,
    :nnzo => 100,
    :nnzh => 5050,
    :nnzj => 0,
    :minimize => true,
    :name => "ncb20b",
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

get_ncb20b_meta(; n::Int=default_nvar) = (ncb20b_meta[:nvar], ncb20b_meta[:ncon])
