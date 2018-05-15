# Generating sequences of files

Source code: [`examples/sequences`](../../examples/sequences)

## List comprehension

A parameter sweep might involve generating a sequence of file names.
This can be done using list comprehension and arithmetic sequences
(see, e.g., §2.4.1 ‘List comprehensions and arithmetic sequences’ in
*A Gentle Introduction to Haskell*); e.g., to generate the sequence of
target names `0.txt`, `2.txt`, …, `9.txt`:
[`examples/sequences/comprehension`](../../examples/sequences/comprehension)
	
```haskell
	want [show n <.> "txt" | n <- [0..9]]
```

followed by a rule for the pattern "*.txt".

It is unclear how a comparable list of targets could be generated in
*GNU Make*.

## map

The same thing can be done with
[`map`](http://hackage.haskell.org/package/base-4.10.1.0/docs/Prelude.html#v:map);
[`examples/sequences/map`](../../examples/sequences/map).

```haskell
  want $ map ((<.> "txt") . show) [0..9]
```

## Explicit lists

If the list of arguments isn't long, it can be given explicitly.

```haskell
  want $ map (<.> "txt") [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

# Two-parameter families

For a two-parameter family, use
[`Control.Applicative.liftA2`](http://hackage.haskell.org/package/base-4.10.1.0/docs/Control-Applicative.html#v:liftA2);
[`examples/sequences/liftA2`](../../examples/sequences/liftA2).

```haskell
  want $ map (<.> "txt") $ liftA2 (++) ["a", "b"] (map show [0 .. 3])
```

This generates
```shell
a0.txt  a1.txt  a2.txt  a3.txt  b0.txt  b1.txt  b2.txt  b3.txt
```
