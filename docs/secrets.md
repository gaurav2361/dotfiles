# Secrets & SOPS (age) — how this repo handles secrets

This repo uses `sops` / `sops-nix` with `age` for encryption. Store secrets encrypted in the repo and provide age private keys locally for decrypting during `home-manager` / `nixos-rebuild` runs.

---

## 1. Architecture & Portability

The secrets configuration is modular and portable:

- **Centralized Module**: Configured in `home/sops.nix` using a custom helper `myLib.mkHomeModule`.
- **Enable/Disable**: Can be toggled via `secrets.sops.enable = true;` (defaults to `true`).
- **Dynamic Paths**: All secret paths use `${config.home.homeDirectory}` instead of hardcoded strings, making the config work seamlessly across different usernames and OSs (macOS/Linux).
- **Secure Permissions**: Private keys (like SSH) are automatically deployed with `0600` permissions.

---

## 2. Generate an `age` keypair

Install `age`. Example:

```bash
# install age (nix)
nix profile install nixpkgs#age
# then generate key
mkdir -p ~/.config/sops/age
age-keygen -o ~/.config/sops/age/keys.txt
```

This creates a private key. The file at `~/.config/sops/age/keys.txt` should **never** be committed.

To see your **public key** (which goes into `.sops.yaml`):

```bash
age-keygen -y ~/.config/sops/age/keys.txt
```

---

## 3. How to use this config with your own secrets

If you are forking or using this config, you must replace the encryption recipients with your own public key:

1. **Update `.sops.yaml`**: Replace the public key under `&gaurav` (or rename it) with your own public key generated in step 2.
2. **Create your secrets file**:
   ```bash
   # Create a new secrets file
   sops secrets/secrets.yaml
   ```
   Add your keys like `github-key`, `signing-key`, etc., inside this file.
3. **Reference in Nix**: The paths are already set up in `hosts/<hostname>/secrets/default.nix`. As long as the keys in your `secrets.yaml` match the names in your Nix files, `sops-nix` will handle the rest.

---

## 4. Host-Specific Secrets (Advanced)

To prevent one compromised machine from accessing secrets for all other machines, we use host-specific encryption.

In `.sops.yaml`, we define:

- `&users`: Personal keys for humans (can decrypt everything).
- `&hosts`: Machine-specific keys (derived from SSH host keys).

### How to get a Host Public Key:

On a NixOS machine:

```bash
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

---

## 5. Local key storage (recommended)

- `~/.config/sops/age/keys.txt` (standard for this repo)

Ensure strict permissions:

```bash
chmod 700 ~/.config/sops/age
chmod 600 ~/.config/sops/age/keys.txt
```

---

## 6. TODO / Future Improvements

See the detailed **[SOPS Roadmap](sops-roadmap.md)** for our plan to improve security through:
- **Host-Specific Keys**: Isolate secrets between machines.
- **Secret Migration**: Reduce "blast radius" by moving global secrets into host-specific files.
- **Hardware Keys**: Moving the master key to a YubiKey.
