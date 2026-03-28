{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  inherit
    (lib.mkModule {
      globalConfig = config;
      name = "darwin.homebrew";
      description = "macOS Homebrew package manager setup";
      config = {
        environment.systemPackages = with pkgs; [ pkg-config ];
        environment = {
          systemPath = [ "/opt/homebrew/bin" ];
          pathsToLink = [ "/Applications" ];
        };
        environment.variables = {
          HOMEBREW_PREFIX = "/opt/homebrew";
          HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
          HOMEBREW_REPOSITORY = "/opt/homebrew";
        };
        nix-homebrew = {
          enable = true;
          user = "gaurav";
          enableRosetta = true;
          autoMigrate = false;
          taps = {
            "homebrew/homebrew-core" = inputs.homebrew-core;
            "homebrew/homebrew-cask" = inputs.homebrew-cask;
            "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
          };
        };
        system.activationScripts.preActivation.text = ''
          echo "━━━ Checking Prerequisites ━━━"
          # Check and install Xcode Command Line Tools
          if ! xcode-select -p &> /dev/null; then
            echo "Installing Xcode Command Line Tools..."
            touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
            PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
            if [ -n "$PROD" ]; then
              softwareupdate -i "$PROD" --verbose
              echo "✓ Xcode Command Line Tools: Installed"
            else
              echo "⚠️  Could not auto-install. Run manually: xcode-select --install"
            fi
            rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
          else
            echo "✓ Xcode Command Line Tools: $(xcode-select -p)"
          fi

          # Check and install Rosetta 2
          if /usr/bin/pgrep -q oahd; then
            echo "✓ Rosetta 2: Installed"
          else
            echo "Installing Rosetta 2..."
            if /usr/sbin/softwareupdate --install-rosetta --agree-to-license 2>/dev/null; then
              echo "✓ Rosetta 2: Installed successfully"
            else
              echo "⚠️  Rosetta 2 installation failed. Run manually:"
              echo "   sudo softwareupdate --install-rosetta --agree-to-license"
            fi
          fi

          echo "━━━ Mac App Store Status ━━━"
          MAS_ACCOUNT_OUTPUT=$(${pkgs.mas}/bin/mas account 2>&1 || true)
          MAS_EXIT_CODE=$?
          if [ $MAS_EXIT_CODE -eq 0 ] && [ -n "$MAS_ACCOUNT_OUTPUT" ]; then
            echo "✓ Mac App Store: Signed in as $MAS_ACCOUNT_OUTPUT"
          else
            if echo "$MAS_ACCOUNT_OUTPUT" | grep -q "not supported"; then
              echo "ℹ️  Mac App Store account check not supported on this macOS version"
              echo "   This is expected on macOS 10.13+ (current: $(sw_vers -productVersion))"
            else
              echo "⚠️  Could not verify Mac App Store sign-in status"
              echo "   Output: $MAS_ACCOUNT_OUTPUT"
            fi
          fi

          echo ""
          echo "━━━ Checking App Store Apps ━━━"
          REQUIRED_APPS="310633997"
          for app_id in $REQUIRED_APPS; do
            if ${pkgs.mas}/bin/mas list 2>/dev/null | grep -q "$app_id" || false; then
              echo "✓ App $app_id: Already installed or in purchase history"
            else
              echo "ℹ️  App $app_id: Not yet in purchase history"
            fi
          done || true
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        '';
        homebrew = {
          enable = true;
          global.brewfile = true;
          onActivation = {
            autoUpdate = false;
            cleanup = "uninstall";
            upgrade = true;
          };
          taps = [
            "homebrew/core"
            "homebrew/cask"
            "mhaeuser/mhaeuser"
            "netbirdio/tap"
          ];
          casks = [
            "iina"
            "blip"
            "motrix"
            "raycast"
            "obsidian"
            "requestly"
            "antigravity"
            "google-drive"
            "google-chrome"
            "brave-browser"
            # "helium-browser"
            "keyboardcleantool"
            # "netbirdio/tap/netbird-ui"
            "mhaeuser/mhaeuser/battery-toolkit"
          ];
          brews = [
            "mas"
            "mole"
            "colima"
            # "docker"
            "libiconv"
            "tesseract"
            "gemini-cli"
            "tree-sitter"
            "docker-buildx"
            "tesseract-lang"
            "docker-compose"
            "tree-sitter-cli"
            # "netbirdio/tap/netbird"
          ];
          masApps = {
            "WhatsApp Messenger" = 310633997;
          };
        };
      };
    })
    options
    config
    ;
}
