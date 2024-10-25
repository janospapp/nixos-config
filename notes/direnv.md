# Random issues

## Local flake.nix missing from the store

While I was experienting with direnv and different devShells or
devenv I got the following error:
```
error: getting status of '/nix/store/xyz...-source/flake.nix': No such file or directory
direnv: nix-direnv: Evaluating current devShell failed. Falling back to previous environment!
```

The root cause was that I generated a new rails application in the folder,
that initialized a git repository. This broke my flake evaluation, but when
I staged all the rails files in git, the flake was evaluated again.
