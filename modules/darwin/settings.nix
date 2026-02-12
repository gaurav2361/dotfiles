{ self, ... }:
{
  # touch ID for sudo
  # security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  # system defaults and preferences
  system = {
    configurationRevision = self.rev or self.dirtyRev or null;

    keyboard = {
      enableKeyMapping = true;
    };

    startup.chime = false;

    defaults = {
      loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
      };

      screencapture = {
        location = "~/Pictures/screenshots";
        target = "file";
        type = "png";
      };

      finder = {
        NewWindowTarget = "Home"; # new finder windows open home dir
        AppleShowAllFiles = true; # hidden files
        AppleShowAllExtensions = true; # file extensions
        _FXShowPosixPathInTitle = true; # title bar full path
        FXRemoveOldTrashItems = true; # auto empty trash
        ShowPathbar = true; # breadcrumb nav at bottom
        ShowStatusBar = true; # file count & disk space
        CreateDesktop = false; # no desktop icons
        QuitMenuItem = true; # allow quitting finder
        ShowExternalHardDrivesOnDesktop = false; # Whether to show external disks on desktop
      };

      NSGlobalDomain = {
        NSAutomaticSpellingCorrectionEnabled = true;
        NSAutomaticCapitalizationEnabled = true;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = true; # on/off animations of windows closing/opening
        NSDocumentSaveNewDocumentsToCloud = false; # default save to disk, not iCloud
        # AppleInterfaceStyle = Dark; # dark mode
        "com.apple.trackpad.scaling" = 3.0;
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };

      dock = {
        orientation = "bottom";
        autohide = true;
        # autohide-delay = 0;
        show-recents = false;
        expose-animation-duration = 0.12;
        show-process-indicators = true;
        tilesize = 32;
        autohide-time-modifier = 1.0;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };
      controlcenter = {
        BatteryShowPercentage = true;
      };
    };
  };

  system.stateVersion = 6;
}
