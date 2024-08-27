{ config, pkgs, lib, push2talk, ... }:
let
  app = pkgs.symlinkJoin {
    name = "waybar-scripts";
    paths = with pkgs; [
      (writeShellScriptBin "waybar-decrypted" (builtins.readFile ./bin/waybar-decrypted))
      (writeShellScriptBin "waybar-progress" (builtins.readFile ./bin/waybar-progress))
      (writeShellScriptBin "waybar-recording" (builtins.readFile ./bin/waybar-recording))
      (writeShellScriptBin "waybar-systemd" (builtins.readFile ./bin/waybar-systemd))
      (writeShellScriptBin "waybar-usbguard" (builtins.readFile ./bin/waybar-usbguard))
      (writeShellScriptBin "waybar-yubikey" (builtins.readFile ./bin/waybar-yubikey))
      coreutils
      dbus
      gawk
      gnugrep
      gnused
      inotify-tools
      netcat-openbsd
      notmuch
      perl
      progress
      systemd
      usbguard
    ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/waybar-decrypted --prefix PATH : $out/bin
      wrapProgram $out/bin/waybar-progress  --prefix PATH : $out/bin
      wrapProgram $out/bin/waybar-recording --prefix PATH : $out/bin
      wrapProgram $out/bin/waybar-systemd   --prefix PATH : $out/bin
      wrapProgram $out/bin/waybar-usbguard  --prefix PATH : $out/bin
      wrapProgram $out/bin/waybar-yubikey   --prefix PATH : $out/bin
    '';
  };
in
{
  home-manager.users.${config.user}.programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [{
      height = 25;

      modules-left = [
        "sway/workspaces"
        "sway/mode"
      ];

      modules-right = [
        "custom/progress"
        "custom/usbguard"
        "custom/yubikey"
        "custom/decrypted"
        "custom/systemd"
        "custom/recording"
        "custom/dnd"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "disk"
        "backlight"
        "sway/language"
        "battery"
        "clock"
      ];

      "custom/progress" = {
        exec = "${app}/bin/waybar-progress";
        return-type = "json";
        interval = 1;
      };

      "custom/usbguard" = {
        format-icons = {
          icon = "<span foreground='#928374'> </span>";
        };
        format = "{icon}{}";
        exec = "${app}/bin/waybar-usbguard";
        return-type = "json";
        on-click = "${app}/bin/waybar-usbguard allow";
        on-click-right = "${app}/bin/waybar-usbguard reject";
      };

      "custom/yubikey" = {
        exec = "${app}/bin/waybar-yubikey";
        return-type = "json";
      };

      "custom/decrypted" = {
        exec = "${app}/bin/waybar-decrypted";
        return-type = "json";
      };

      "custom/systemd" = {
        exec = "${app}/bin/waybar-systemd";
        return-type = "json";
        interval = 10;
      };

      "custom/dnd" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "<span foreground='#928374'></span>";
          none = "<span foreground='#928374'></span>";
          dnd-notification = "<span foreground='#928374'></span>";
          dnd-none = "<span foreground='#928374'></span>";
        };
        return-type = "json";
        exec = "${lib.getExe' pkgs.swaynotificationcenter "swaync-client"} --subscribe-waybar";
        on-click = "${lib.getExe' pkgs.swaynotificationcenter "swaync-client"} --toggle-dnd --skip-wait";
        escape = true;
      };

      "custom/recording" = {
        exec = "${app}/bin/waybar-recording";
        return-type = "json";
        signal = 3;
        interval = "once";
      };

      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format = "<span foreground='#928374'></span> {:%a, %d %b  <span foreground='#928374'></span> %H:%M}";
      };

      cpu = {
        format = "<span foreground='#928374'></span> {usage}%";
        states = {
          warning = 70;
          critical = 90;
        };
      };

      disk = {
        format = "<span foreground='#928374'></span> {percentage_free}%";
        states = {
          warning = 70;
          critical = 90;
        };
      };

      memory = {
        format = "<span foreground='#928374'></span> {}%";
        states = {
          warning = 70;
          critical = 90;
        };
      };

      backlight = {
        format = "<span foreground='#928374'>{icon}</span> {percent}%";
        format-icons = [ "" ];
        tooltip = false;
      };

      "sway/language" = {
        min-length = 3;
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "<span foreground='#928374'>{icon}</span> {capacity}%";
        format-charging = "<span foreground='#928374'></span> {capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };

      network = {
        interval = 2;
        format-wifi = "<span foreground='#928374'></span> {essid}";
        format-ethernet = "<span foreground='#928374'></span> {ifname}";
        format-linked = "<span foreground='#928374'></span> {ifname}";
        format-disconnected = " <span foreground='#928374'></span> ";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}\n {bandwidthDownBits}\n {bandwidthUpBits}";
      };

      pulseaudio = {
        format = "<span foreground='#928374'>{icon}</span> {volume}%   {format_source}";
        format-bluetooth = "<span foreground='#928374'>{icon}</span> {volume}%   {format_source}";
        format-bluetooth-muted = "<span foreground='#928374'> {icon}</span>   {format_source}";
        format-muted = "<span foreground='#928374'></span>   {format_source}";
        format-source = "<span foreground='#928374'></span> {volume}%";
        format-source-muted = "<span foreground='#928374'></span>";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "" ];
        };
        on-click = lib.getExe pkgs.pavucontrol;
        on-click-right = "${lib.getExe push2talk} -t";
        on-click-middle = lib.getExe pkgs.helvum;
      };
    }];

    style = ''
      @define-color background #1d2021;
      @define-color foreground #ebdbb2;
      @define-color dim        #928374;
      @define-color yellow     #fabd2f;
      @define-color red        #fb4934;
      @define-color green      #b8bb26;

      * {
        background: @background;
        border: none;
        border-radius: 0;
        font-family: Input, "Font Awesome 6 Free Solid";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: @background;
        color: @foreground;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      #workspaces button {
        padding: 0 10px;
        background: transparent;
        color: @foreground;
        border-top: 3px solid @background;
        border-bottom: 3px solid transparent;
      }

      #workspaces button.focused {
        border-bottom: 3px solid @green;
      }

      #workspaces button.urgent {
        border-bottom: 3px solid @yellow;
      }

      #mode {
        border-bottom: 3px solid @red;
      }

      #custom-usbguard,
      #custom-decrypted,
      #battery.warning,
      #disk.warning,
      #memory.warning,
      #cpu.warning,
      #custom-dnd.dnd-notification,
      #custom-dnd.dnd-none {
        border-top: 3px solid @background;
        border-bottom: 3px solid @yellow;
      }

      #custom-systemd,
      #battery.critical,
      #disk.critical,
      #memory.critical,
      #cpu.critical,
      #custom-yubikey,
      #custom-recording {
        border-top: 3px solid @background;
        border-bottom: 3px solid @red;
      }

      #battery.charging {
        border-top: 3px solid @background;
        border-bottom: 3px solid @green;
      }

      #mode,
      #pulseaudio,
      #custom-usbguard,
      #custom-yubikey,
      #custom-decrypted,
      #custom-systemd,
      #network,
      #cpu,
      #disk,
      #memory,
      #backlight,
      #battery,
      #clock {
        padding: 0 6px;
        margin: 0 6px;
      }

      #custom-dnd,
      #custom-recording,
      #language {
        padding: 0;
        margin: 0 6px;
      }

      #tray {
        margin-left: -1000000px;
      }

      #backlight,
      #battery,
      #clock,
      #cpu,
      #custom-progress,
      #custom-recording,
      #custom-systemd,
      #custom-usbguard,
      #custom-yubikey,
      #disk,
      #memory,
      #mode,
      #network,
      #pulseaudio {
        color: @foreground;
      }

      #custom-decrypted {
        color: @dim;
      }
    '';
  };
}
