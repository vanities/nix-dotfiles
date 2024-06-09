{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./crypttab.nix
    ./docker.nix
    ./earlyoom.nix
    ./fstrim.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./pkgs.nix
    ./power.nix
    ./security.nix
    ./ssh.nix
    ./sudo.nix
    ./swap.nix
    ./systemd.nix
    ./udisks2.nix
    ./usbguard.nix
    ./users.nix
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.zsh.enable = true;
  programs.adb.enable = true;
  programs.yubikey-touch-detector.enable = true;

  system.stateVersion = "24.05";
}
