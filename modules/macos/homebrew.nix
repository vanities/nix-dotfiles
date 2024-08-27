{
  system.activationScripts.preUserActivation.text = ''
    if ! xcode-select --version 2>/dev/null; then
      run xcode-select --install
    fi
    if ! /opt/homebrew/bin/brew --version 2>/dev/null; then
      run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      # my stuff
      "1password"
      "alfred"
      "balenaetcher"
      "bdinfo"
      "dropbox"
      "font-hack-nerd-font"
      "gpg-suite"
      "kitty"
      "ledger-live"
      "libreoffice"
      "mactex"
      "monero-wallet"
      "ngrok"
      "paintbrush"
      "timemachineeditor"
      "visual-studio-code"
      "sf-symbols"

      # Development Tools
      "homebrew/cask/docker"
      "neovim"
      "istat-menus"

      # Communication Tools
      "discord"
      "notion"
      "slack"
      "telegram"
      "zoom"
      "signal"

      # Utility Tools
      "syncthing"
      "caffeine"

      # Entertainment Tools
      "vlc"
    ];
  };
}
