{ pkgs, ... }: {
  system = {
    keyboard = {
      remapCapsLockToControl = true;
      enableKeyMapping = true;
    };

    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        AppleShowAllExtensions = true;

        NSDocumentSaveNewDocumentsToCloud = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;
      };

      dock = {
        autohide = true;
        enable-spring-load-actions-on-all-items = true;
        mouse-over-hilite-stack = true;

        mineffect = "genie";
        orientation = "bottom";
        show-recents = false;
        tilesize = 44;

        persistent-apps = [
          "${pkgs.firefox-bin}/Applications/Firefox.app"
          "${pkgs.kitty}/Applications/Kitty.app"
        ];
      };

      finder = {
        FXPreferredViewStyle = "clmv";
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        _FXShowPosixPathInTitle = false;
        QuitMenuItem = true;
      };

      LaunchServices.LSQuarantine = false;

      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.dock" = {
          magnification = true;
          largesize = 48;
        };
        "com.apple.finder" = {
          WarnOnEmptyTrash = false;
          FXDefaultSearchScope = "SCcf";
          FXPreferredViewStyle = "clmv";
        };
      };
    };
  };
}
