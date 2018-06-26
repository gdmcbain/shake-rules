# Installing Shake

## Installing Haskell Stack

[Install](https://docs.haskellstack.org/en/stable/README/#how-to-install)
the [Haskell Stack](https://haskellstack.org).

## Installing Shake

```shell
stack install shake
```

# Installing this repository of extras for Shake

### Installing other utilities

Our standard [`Build.hs`](Build.hs) Shake script defines
[`cleanRule`](Development/Shake/Clean.hs) which invokes `flake8` and
`hlint`.  To install these:

```shell
pip install flake8
stack install hlint
```

## Installing this repository of extras for Shake

```shell
cd ~/src  # or wherever
git clone https://github.com/gdmcbain/shake-rules.git
```

Then edit the `packages` field of `~/.stack/global-project/stack.yaml` to contain a relative path to the installation:
```yaml
packages:
  - ../../src/shake-rules
```

Then to use the package in a non-Stack project using Shake (i.e. in a
directory containing neither `stack.yaml` or `*.cabal` files, but with
a `Build.hs` script), install this package.

```shell
stack install shake-rules
```

## Using this repository in your projects

Having installed this package as above, nothing special needs to be
done in your projects: it has access to the provided modules such as
[`Development.Shake.Clean`](src/Development/Shake/Clean.hs).

You may begin by copying the template [`Build.hs`](Build.hs) script.

```shell
cd ${YOUR_PROJECT}
cp ~/src/shake-rules/Build.hs .
```

Then edit [`Build.hs`](Build.hs) as required.

### Compiling the build

After editing the [`Build.hs`](Build.hs) as required, it may be compiled.

```shell
./Build.hs compile
```

(This rule is included in `cleanRules`, so it is assumed here that
that was not deleted from [`Build.hs`](Build.hs).)

Then the compiled version can be called in the same way.

```shell
alias build=.shake/build
build clean
build -V  # &c.
```
