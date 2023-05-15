# Algebras
```@meta
CurrentModule = Hecke
```

We have algebras in Hecke, which is nice.


## Creation

```@docs
AbsAlgAss
AlgAss
AlgGrp
group_algebra
getindex(::Ring, ::Group)
matrix_algebra
regular_matrix_algebra
```

Further methods:
```
CrossedProductAlgebra
```

## Properties

```@docs
basis
gens
trace_matrix
decompose
as_number_fields
radical
maximal_eichler_quotient_with_projection
central_primitive_idempotents
```

Common methods
```
dim
degree
order_type
morphism_type
```

For `AlgAss`
```@docs
multiplication_table
is_commutative
center
```

```
find_one
opposite_algebra
```

## Constructions

```@docs
subalgebra
components
restrict_scalars
product_of_components_with_projection
product_of_components
```

For `AlgAss`
```@docs
quo
direct_product
```

```
quaternion_algebra2
```

## Further Methods
```
rand
kernel_of_frobenius
primitive_element
is_simple
is_semisimple
is_etale
trace_signature
```


### Modules

```@docs
ModAlgAss
Amodule(::AbsAlgAss, ::Vector{<:MatElem})
Amodule(::Vector{<:MatElem})
coefficient_ring(::ModAlgAss)
has_algebra(::ModAlgAss)
has_matrix_action(::ModAlgAss)
action
```

#### Meataxe

```@docs
# meataxe
closure
composition_series
composition_factors_with_multiplicity
minimal_submodules
maximal_submodules
submodules
```

#### Lattices

```@docs
lattice
natural_lattice
endomorphism_ring
reduction
change_coefficient_ring
```

### Ideals

```@docs
ideal(::AbsAlgAss, x)
ideal(::AbsAlgAss, x, y)
ideal_from_gens
basis(a::AbsAlgAss)
basis_matrix
is_right_ideal
is_left_ideal
```

### Ramification

```@docs
is_split
schur_index
```

### Orders

### Elements

```@docs
matrix
coefficients
representation_matrix
tr
trred
norm
normred
trred_matrix
```

```@docs
is_integral
is_divisible
is_invertible
minpoly
charpoly
```

### Example

```@repl
using Hecke; # hide
AlgAss(MatrixAlgebra(QQ, 2))
```

```@repl
using Hecke; # hide
QQx, x = PolynomialRing(QQ)
AlgAss(x^2-1)
```

```@repl
using Hecke; # hide
G = symmetric_group(5)
AlgGrp(QQ, G) == group_algebra(QQ, G) == QQ[G]
```

