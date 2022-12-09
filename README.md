# Nix, NixOS and Home Manager for mipmip's machine park

This is my mono-repository for my machines configuration and my dotfiles.

### TODO

- [ ] fix NUR url, maybe nur.nix
- [ ] public features and documentation## Usage

### MacOS Provisioning

For macOS provisioning I only use Home-Manager from Nix. Cli tools are declared
in home-pim/programs/macos-bundle.nix. Other mac-apps are in
`home-pim/files-macos/Brewfile`. Install them with `brew bundle install`

- install [Homebrew](https://brew.sh/)
- install Nix on mac](https://nixos.org/download.html#nix-install-macos).
- then install Home Manager. See [Home Manager Manual](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)

### NixOS Programming

#### Check for missing modules

when refactoring it's nice to quickly see which hosts have missing modules. To
see this run:

```
./RUNME.sh missing_modules
```

### Home-Manager

Make sure home-manager is installed. On Mac I home-manager as single user
install. On nixos home-manager is installed automatically.

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

## Features

### Linux Desktop Highlights

I use GNOME as desktop environment with a few extensions to give me some
features I'm used too from the time I used macOS as primary OS.

### Programming and writing

I payed a lot of time optimizing my terminal and vim configuration. I use
[St](https://st.suckless.org) with a few patches for better aesthetics.

My St/Vim writing configuration has a larger line height, a dedicated font, a
pure white background together with a grayscale writing theme. Here's a pic
showing my writing environment.

![writing in vim](./docs/gelukkigmetvim.png)


