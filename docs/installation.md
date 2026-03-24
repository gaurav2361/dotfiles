# Installation

This document contains platform-specific installation instructions for using these dotfiles.
We keep platform-specific commands separated to avoid confusion.

> **Note:** these instructions assume you have `git` and basic system tools installed.

---

## 1. Prerequisites

### Install Nix

We recommend the **Determinate Nix Installer** for a modern, flake-ready experience:

```bash
# macOS & Linux
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

### Setup SOPS (Age Key)
**CRITICAL**: You MUST have your age private key in place **before** your first build, or `sops-nix` will fail to decrypt secrets.

1.  Follow **[Secrets Guide](secrets.md)** to generate your key.
2.  Ensure it is at `~/.config/sops/age/keys.txt`.

---

## 2. Quick Clone

```bash
git clone --recurse-submodules https://github.com/gaurav2361/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

---

## 3. Bootstrap & Build

### macOS (Darwin)

If this is your first time setting up `nix-darwin`, bootstrap using the experimental `nix run`:

```bash
# Bootstrap using the 'coffee' host configuration
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#coffee
```

### Linux (NixOS)

```bash
# Build and switch to the 'atlas' host configuration as root
sudo nixos-rebuild switch --flake .#atlas
```

---

## 4. Modern Management with `nh` (Recommended)

This configuration includes **`nh` (Nix Helper)** for a better CLI experience.

### System Updates
Instead of `nixos-rebuild` or `darwin-rebuild`, use:

```bash
nh os switch . -- --hostname <hostname>
```

### Home Manager Updates
Instead of `home-manager switch`, use:

```bash
nh home switch . -- --hostname <username>@<hostname>
```

---

## 5. Standard Tools (Fallback)

If you don't use `nh` or prefer the standard commands:

### Home Manager (Standalone)
```bash
home-manager switch --flake .#gaurav@coffee
```

### Manual Flake Build
```bash
nix build .#darwinConfigurations.coffee.system
./result/sw/bin/darwin-rebuild switch --flake .#coffee
```

---

## Post-install

1.  **Git Configuration**: Ensure your user details are set in `config/git/config`.
2.  **Shell**: If you switched to Zsh/Nushell, you might need to add them to `/etc/shells` if Nix didn't do it automatically.
3.  **Secrets**: Re-run the switch command after adding your SSH/Signing keys to your personal `secrets.yaml`.

---

## Troubleshooting

- **Missing Keys**: If you get a "SOPS error" during build, check `~/.config/sops/age/keys.txt`.
- **Experimental Features**: If `nix` commands fail, ensure `nix-command` and `flakes` are in `nix.conf`.
- **Dirty Tree**: If the flake doesn't pick up new files, remember to `git add` them first.
