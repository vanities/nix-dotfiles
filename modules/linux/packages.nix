{ config, pkgs, push2talk, ... }: {
  home-manager.users.${config.user}.home.packages = with pkgs; [
    android-tools
    android-udev-rules
    asahi-bless
    bfs
    brightnessctl
    calibre
    cargo
    chromium
    curlie
    dbmate
    delta
    dfrs
    doggo
    dos2unix
    dua
    earlyoom
    editorconfig-core-c
    eza
    fd
    ff2mpv-rust
    ffmpeg
    file
    freerdp
    fzf
    gcc
    git
    glib
    gnumake
    go
    goimapnotify
    grim
    helvum
    inotify-tools
    iptables-nftables-compat
    isync
    jq
    just
    kitty
    kubelogin
    kubernetes-helm
    kubectl
    kubectx
    libnotify
    libreoffice
    magic-wormhole-rs
    meld
    msmtp
    mysql-client
    netcat-openbsd
    nftables
    nodejs
    notmuch
    nzbget
    p7zip
    pam_u2f
    pass
    pavucontrol
    perlPackages.vidir
    pgcli
    pigz
    pinentry-gnome3
    playerctl
    postgresql_16
    progress
    pulseaudio
    push2talk
    pwgen
    python3
    qalculate-gtk
    qrencode
    rsync
    signal-desktop
    sipcalc
    slurp
    socat
    sops
    sqlite
    swappy
    swaybg
    sway-contrib.inactive-windows-transparency
    swaylock
    swayr
    syncthing
    systembus-notify
    teehee
    tig
    trash-cli
    tree
    udiskie
    unrar
    unzip
    usbguard
    vimiv-qt
    vivid
    vscode
    w3m
    wf-recorder
    wireguard-tools
    wl-clipboard
    wldash
    zathura
    zip
    zsh
  ];
}
