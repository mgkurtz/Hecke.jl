Mod = ModAlgAss

@doc Markdown.doc"""
    meataxeChar0(M::Mod) -> Vector{Mod}

Given a semisimple module $M$ return simple submodules which add up to $M$.

The underlying algebra $A$ can be chosen as a subalgebra of $\operator{Mat}_N\mathbf Q$.
Implements algorithm by Allan Steel.
"""
function meataxeChar0(M::Mod)
    reduce(vcat, split_homogeneous.(homogeneous_components(M)))
end

@doc Markdown.doc"""
    homogeneous_components(M::Mod) -> Vector{Mod}

Return homogeneous $S_i$ such that $M=\bigoplus_i S_i=M$.

The input $M$ needs to be semisimple. Homogeneous means to be isomorphic to a
direct sum of copies of some simple module.

See also [`split_homogeneous(::Mod)`](@ref).
"""
function homogeneous_components(M::Mod)
    z, zhom = center_of_endomorphism_ring(M)
    dim(z) == 1 && return [M]
    B = elements(lll(saturate(matrix(basis(z)))))
    for b in B
        f = minpoly(b)
        is_irreducible(f) && deg(f) == 1 && return [M]
        fs = factor(f)
        length(fs) == 1 && continue
        singularElements = (zhom((p^e)(b)) for (p, e) in fs)
        return vcat(homogeneous_components(sub(M, s)) for s in singularElements)
    end
    return [M]
end

function center_of_endomorphism_ring(M::Mod)
    endM, endMhom = endomorphism_algebra(M)
    z, zhom = center(endM)
    return z, endMhom ∘ zhom
end


# Stolen from `ideal_from_lattice_gens` in AlgAssAbsOrd/Ideal.jl
function matrix(v::Vector{AlgAssElem{fmpq}})
    @assert !isempty(v)
    M = zero_matrix(QQ, length(v), dim(parent(v[1])))
    for (i, a) in enumerate(v)
        elem_to_mat_row!(M, i, a)
    end
    M
end

function elements(a::AlgAss{fmpq}, m::fmpq_mat)
    v = Vector{AlgAssElem{fmpq}, AlgAss{fmpq}}(undef, size(m, 1))
    for i in axes(m, 1)
        v[i] = elem_from_mat_row(a, m, i)
    end
    v
end

function sub(M::Mod, a::ModElem)
end

# exists already for fmpz_mat
function saturate(m::fmpq_mat)
end

# ===

@doc Markdown.doc"""
    split_homogeneous(M::Mod) -> Vector{Mod}

Return pairwise isomorphic simple $S_i$ such that $M=\bigoplus_i S_i=M$.

The input $M$ needs to be homogeneous, i.e. allow such a decomposition.

See also [`homogeneous_components(::Mod)`](@ref).
"""
function split_homogeneous(M::Mod)
    endM, endMhom = endomorphism_algebra(M)
    o = maximal_order(endM)
    maximal_order_is_trivial? && return [M]
    s = maximal_order_basis_search(o)
    fs = factor(minpoly(s))
    @assert length(fs) > 1
    singularElements = (endMhom((p^e)(s)) for (p, e) in fs)
    return vcat(split_homogeneous.(kernel.(singularElements)))
end

function maximal_order_basis_search(v::Vector{AlgElem})
    (a = find(is_split, v)) !== nothing && return a
    for b1 in v, b2 in v
        is_split(b1 * b2) && return b1 * b2
        is_split(b1 + b2) && return b1 + b2
    end
    while a === nothing
        a = find(is_split, lll(rand(v) * rand(v) for _ in eachindex(v)))
    end
    return a
end

find(f, v) = (i = findfirst(f, v); i === nothing ? nothing : f[i])

is_split(a::Element) = !is_irreducible(minpoly(a))
