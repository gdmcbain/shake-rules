# Installation in the WSL

```shell
sudo aptitude install haskell-stack
stack update
stack upgrade
export PATH=~/.local/bin:$PATH
```

Then in the top-level directory of shake-rules
```shell
shake build
```
