# Currently meataxe over fields of characteristic zero will fail in general
# Below are some tests, that certify that and which eventually shall run without throwing.
#
# For completeness of tests, these are MeatAxe.jl’s exports:
# submodules, minimal_submodules, maximal_submodules, composition_series, composition_factors_with_multiplicity, meataxe

@testset "MeataxeChar0" begin

  @testset "composition factors and series" begin
    # example by Claus Fieker, using Oscar
    # generators = mat.(irreducible_modules(QQ, transitive_group(8, 5))[end].ac)
    generators = MatrixSpace(QQ,4,4).([
      [ 0  1  0  0
       -1  0  0  0
        0  0  0 -1
        0  0  1  0],
      [ 0  0 -1  0
        0  0  0 -1
        1  0  0  0
        0  1  0  0]
     ])

    M = Hecke.Amodule(generators)

    @test_throws "Too many attempts" Hecke.composition_factors_with_multiplicity(M)
    @test_throws "Too many attempts" Hecke.composition_series(M)
  end

end
