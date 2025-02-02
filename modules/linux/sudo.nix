{
  security.sudo = {
    enable = true;

    extraConfig = ''
      Defaults timestamp_timeout=0
      Defaults passwd_timeout=0
    '';

    extraRules = [{
      groups = [ "wheel" ];
      commands = [
        { command = "/run/current-system/sw/bin/systemctl stop pcscd.service"; options = [ "SETENV" "NOPASSWD" ]; }
      ];
    }];
  };
}
