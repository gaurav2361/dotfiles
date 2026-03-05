# modules/darwin/homebrew.nix
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  environment.systemPackages = with pkgs; [
    pkg-config
  ];

  environment = {
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  environment.variables = {
    HOMEBREW_PREFIX = "/opt/homebrew";
    HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
    HOMEBREW_REPOSITORY = "/opt/homebrew";
  };

  # IMPORTANT: This installs Homebrew via nix-homebrew
  nix-homebrew = {
    enable = true;
    user = "gaurav";
    enableRosetta = true; # This enables Rosetta support
    autoMigrate = false;

    # Key: install Homebrew if not present
    # This will happen BEFORE the homebrew module tries to run
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
  };

  # System activation scripts to ensure prerequisites are installed
  system.activationScripts.preActivation.text = ''
    echo "━━━ Checking Prerequisites ━━━"

    # Check and install Xcode Command Line Tools
    if ! xcode-select -p &> /dev/null; then
      echo "Installing Xcode Command Line Tools..."
      # This triggers the installation without blocking
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

    # Check if signed into Mac App Store
    # Note: 'mas account' is not supported on macOS 10.13+ due to Apple's changes
    # See: https://github.com/mas-cli/mas#known-issues
    echo "━━━ Mac App Store Status ━━━"

    # Use || true to prevent command failures from stopping activation
    MAS_ACCOUNT_OUTPUT=$(${pkgs.mas}/bin/mas account 2>&1 || true)
    MAS_EXIT_CODE=$?

    if [ $MAS_EXIT_CODE -eq 0 ] && [ -n "$MAS_ACCOUNT_OUTPUT" ]; then
      echo "✓ Mac App Store: Signed in as $MAS_ACCOUNT_OUTPUT"
    else
      # Check if it's the "not supported" error
      if echo "$MAS_ACCOUNT_OUTPUT" | grep -q "not supported"; then
        echo "ℹ️  Mac App Store account check not supported on this macOS version"
        echo "   This is expected on macOS 10.13+ (current: $(sw_vers -productVersion))"
        echo "   As long as you're signed into the App Store app, mas apps will install fine"
        echo ""
        echo "   To verify you're signed in:"
        echo "   1. Open the App Store application"
        echo "   2. Check if you see your account icon in the bottom left"
        echo "   3. If not signed in, click 'Sign In' and log in with your Apple ID"
      else
        echo "⚠️  Could not verify Mac App Store sign-in status"
        echo "   Please ensure you're signed in via the App Store application"
        echo "   Output: $MAS_ACCOUNT_OUTPUT"
      fi
    fi

    # Check if required apps are in purchase history (this still works)
    echo ""
    echo "━━━ Checking App Store Apps ━━━"

    # List of app IDs we want to install
    REQUIRED_APPS="310633997"  # WhatsApp

    for app_id in $REQUIRED_APPS; do
      # Use || true to prevent grep failures from stopping activation
      if ${pkgs.mas}/bin/mas list 2>/dev/null | grep -q "$app_id" || false; then
        echo "✓ App $app_id: Already installed or in purchase history"
      else
        echo "ℹ️  App $app_id: Not yet in purchase history"
        echo "   To enable automatic installation:"
        echo "   1. Open the App Store and search for the app"
        echo "   2. Click 'Get' or the download icon"
        echo "   3. You can cancel the download immediately after"
        echo "   This associates the app with your Apple ID for mas to install"
      fi
    done || true  # Ensure the loop doesn't fail activation

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  '';

  # Configure what to install via Homebrew
  homebrew = {
    enable = true;
    # caskArgs.no_quarantine = true;
    global.brewfile = true;
    # Only enable if brew is already installed
    # This prevents the error on first run
    onActivation = {
      autoUpdate = false;
      cleanup = "uninstall";
      upgrade = true;
    };

    taps = [
      "homebrew/core"
      "homebrew/cask"
      "mhaeuser/mhaeuser"
    ];

    casks = [
      "obsidian"
      "google-chrome"
      "google-drive"
      # "spotify"
      "raycast"
      "blip"
      # "android-file-transfer"
      "brave-browser"
      # "helium-browser"
      "iina"
      "requestly"
      "antigravity"
      "mhaeuser/mhaeuser/battery-toolkit"
      # "iordv/tap/droppy"
      # "finetune"
      "keyboardcleantool"
      "motrix"
      # "adobe-creative-cloud"
      # "epic-games"
    ];

    brews = [
      "mas" # Ensure mas is available via Homebrew too
      "tesseract-lang"
      "tesseract"
      "docker-buildx"
      "docker"
      "docker-compose"
      "colima"
      "tree-sitter-cli"
      "tree-sitter"
      "mole"
      "libiconv"
      # "qbittorrent"
    ];

    # Mac App Store apps
    # IMPORTANT: You must "Get" these apps in the Mac App Store at least once
    # to associate them with your Apple ID before they can be installed via mas
    masApps = {
      # "WhatsApp Messenger" = 310633997;
      # Add more apps here after obtaining them in the App Store
      # Use `mas search "app name"` to find IDs
    };
  };
}
