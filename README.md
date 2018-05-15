> A huge benefit of using an embedded DSL as a build system is that we can use the facilities of the host language ([Haskell](https://haskell.org)) to build abstractions on top of [Shake](https://shakebuild.com), to fit our particular use case

(Mokhov, A., N. Mitchell, S. Peyton Jones, & S. Marlow 2016. [Non-recursive Make considered harmful: build systems at scale](http://dx.doi.org/10.1145/2976002.2976011). In _Proceedings of the 9th International Symposium on Haskell—Haskell 2016,_ pp. 170–181. ACM Press. §1)


# Installation

See [INSTALL.md](INSTALL.md).

# Features

## Build.hs

[Build.hs](Build.hs) is a basic template which can be copied and modified.

## Development.Shake.Clean (cleanRules)

The [`Development.Shake.Clean`](Development/Shake/Clean.hs) module
provides a handy standard `cleanRules` function which:
* runs standard checks
  * [`hlint`](https://github.com/ndmitchell/hlint)
  * [`flake8`](http://flake8.pycqa.org/)
* removes files with names matching one of the given list of patterns,
  typically used to clean up generated files of one kind or another

## Development.Shake.Gmsh (gmshRules)

The [`Development.Shake.Gmsh`](Development/Shake/Gmsh.hs) module
provides a `gmshRules` function which given a dimension (1, 2, or 3)
generates a rule for making a `.msh` mesh from a `.geo` geometry-file.
