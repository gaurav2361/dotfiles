{
  self,
  config,
  lib,
  ...
}:
lib.mkModule {
  globalConfig = config;
  name = "darwin.settings";
  description = "macOS system defaults and UI settings";
  config = {
    security.pam.services.sudo_local = {
      touchIdAuth = true;
      reattach = true;
    };
    system = {
      configurationRevision = self.rev or self.dirtyRev or null;
      keyboard.enableKeyMapping = true;
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
          NewWindowTarget = "Home";
          AppleShowAllFiles = true;
          AppleShowAllExtensions = true;
          _FXShowPosixPathInTitle = true;
          FXRemoveOldTrashItems = true;
          ShowPathbar = true;
          ShowStatusBar = true;
          CreateDesktop = false;
          QuitMenuItem = true;
          ShowExternalHardDrivesOnDesktop = false;
        };
        NSGlobalDomain = {
          NSAutomaticSpellingCorrectionEnabled = true;
          NSAutomaticCapitalizationEnabled = true;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticWindowAnimationsEnabled = true;
          NSDocumentSaveNewDocumentsToCloud = false;
          "com.apple.trackpad.scaling" = 3.0;
          AppleShowAllExtensions = true;
          InitialKeyRepeat = 15;
          KeyRepeat = 2;
        };
        dock = {
          orientation = "bottom";
          autohide = true;
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
        controlcenter.BatteryShowPercentage = true;
      };
      stateVersion = 6;
    };
  };
}
