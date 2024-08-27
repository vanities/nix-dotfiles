{ lib, pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      curl
      git
      neovim
      wget
    ];

    variables = {
      EDITOR = lib.getExe pkgs.nvim;
      VISUAL = lib.getExe pkgs.nvim;
    };
  };
}
