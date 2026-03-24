# Roadmap: SOPS Secret Architecture Evolution

This document outlines the strategy for moving from a single-user secret model to a multi-host, secure architecture.

## Phase 1: Host-Specific Keys (Security Isolation)

**Goal**: Ensure that if one machine (e.g., a laptop) is stolen, the secrets for other machines (e.g., a home server) remain encrypted and inaccessible.

### 1. Identify Host Keys

Each machine should have its own `age` key.

- **NixOS (`atlas`, `hades`)**: Use the existing SSH host key to avoid managing extra files.
  ```bash
  nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
  ```
- **macOS (`coffee`)**: Generate a unique age key for the machine.
  ```bash
  age-keygen -o ~/.config/sops/age/keys.txt
  ```

### 2. Update `.sops.yaml` Structure

Refactor the global config to support key groups:

```yaml
keys:
  - &users:
    - &gaurav age1... # Master key (can decrypt everything)
  - &hosts:
    - &atlas age1...
    - &coffee age1...
    - &hades age1...

creation_rules:
  # Host-specific rules
  - path_regex: hosts/atlas/.*\.yaml$
    key_groups: [{ age: [*gaurav, *atlas] }]

  # Shared secrets (all machines)
  - path_regex: secrets/.*\.yaml$
    key_groups: [{ age: [*gaurav, *atlas, *coffee, *hades] }]
```

---

## Phase 2: Reducing the "Blast Radius"

**Goal**: Move secrets out of the global `secrets/secrets.yaml` and into host-specific files.

### 1. Secret Migration

- **Global**: Keep only what is truly shared (e.g., personal Git signing keys used everywhere).
- **Host-Specific**: Move things like `indiefluence-vps` keys (only used on `coffee`) into `hosts/coffee/secrets.yaml`.

### 2. Update Nix Imports

Update the `sops.defaultSopsFile` in each host's secret module to point to their specific file if needed, or keep the global one as a fallback.

---

## Phase 3: Hardware Security (Future)

**Goal**: Move the master user key (`&gaurav`) to a hardware security module (YubiKey).

- **Tool**: `age-plugin-yubikey`
- **Benefit**: Even if your laptop is compromised, the master secrets cannot be decrypted without the physical YubiKey being plugged in and a PIN being entered.

---

## Implementation Checklist

- [ ] Gather public age keys for all 3 hosts.
- [ ] Refactor `.sops.yaml` with `&hosts` block.
- [ ] Create `hosts/coffee/secrets.yaml` and move VPS keys there.
- [ ] Re-encrypt all files using `sops updatekeys <file>`.
