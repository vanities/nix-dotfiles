#!/usr/bin/env zsh

source /etc/profiles/per-user/maximbaz/etc/profile.d/hm-session-vars.sh

[[ "$TTY" == /dev/tty* ]] || return 0

export GPG_TTY="$TTY"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
systemctl --user import-environment GPG_TTY SSH_AUTH_SOCK

if [[ -z $DISPLAY && "$TTY" == "/dev/tty1" ]]; then
    systemd-cat -t sway sway
    systemctl --user stop graphical-session.target
    systemctl --user unset-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK I3SOCK
fi
