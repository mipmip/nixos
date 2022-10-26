# Setup Home-Manager

Make sure home-manager is installed.

Create home dir conf:

```sh
mkdir -p ~/.config/nixpkgs
echo "{\n  allowUnfree = true;\n}" > ~/.config/nixpkgs/config.nix
```

Make the symlink `~/.config/nixpkgs/home.nix` pointing to one of the home-confs
located in `~/nixos/home-pim/`


```sh
ln -s ~/nixos/home-pim/home-[some-home-conf].nix ~/.config/nixpkgs/
```

Test configuration with:

```
home-manager switch
```

