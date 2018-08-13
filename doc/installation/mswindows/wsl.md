# Installation in the WSL

```shell
sudo aptitude install haskell-stack
stack update
stack upgrade
export PATH=~/.local/bin:$PATH
```

Then in the top-level directory of shake-rules
```shell
git pull
shake build
```

Then anywhere _outside_ a Haskell Stack project
```shell
ed ~/.stack/global-project/stack.yaml
# packages:
#   - /home/${USER}/<PATH>/shake-rules
stack install shake-rules
```
