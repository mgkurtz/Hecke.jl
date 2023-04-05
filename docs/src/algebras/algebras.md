# Algebras
```@meta
CurrentModule = Hecke
```

We have algebras in Hecke, which is nice.


## Creation and basic properties

```@docs
AlgAss
MatrixAlgebra # AbstractAlgebra.Generic
matrix_algebra # Hecke
AlgGrp
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

