{ config, lib, pkgs, push2talk, ... }:
let
  systemdService = { Description, ExecStart, Environment ? "" }: {
    Unit = {
      Description = Description;
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Environment = Environment;
      ExecStart = ExecStart;
      Restart = "on-failure";
      RestartSec = 10;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
in
{
  home-manager.users.${config.user}.systemd.user.services = {
    push2talk = systemdService {
      Description = "push2talk";
      Environment = [ "PUSH2TALK_KEYBIND=Super_R" ];
      ExecStart = lib.getExe push2talk;
    };

    sway-inactive-windows-transparency = systemdService {
      Description = "Make inactive windows in sway semi-transparent";
      Environment = [ "INACTIVE_OPACITY=0.7" ];
      ExecStart = lib.getExe pkgs.sway-contrib.inactive-windows-transparency;
    };
  };
}
