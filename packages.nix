{ config, pkgs, fetchurl, ... }:

{
  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    stow
    sudo
    ncdu

    gzip
    unar
    unzip
    zsh

    # Build toolchains
    autoconf
    automake
    gnumake
    scons
    cmake
    gcc8
    clang
    clang-analyzer
    clang-manpages
    clang-tools
    pipx
    bun
    pkg-config
    openssl
    go
    docker
    SDL2

    rustup
    python3
    nodejs_18
    corepack

    # GUI tools
    kicad-small
    xfce.thunar
    xfce.thunar-archive-plugin
    libsForQt5.koko
    firefox
    alacritty
    vlc
    pavucontrol
    discord
    spotify
    nwg-look
    jetbrains-toolbox
    aseprite
    godot_4
    alsa-tools
    insomnia
    # CLI Tools
    neofetch
    bat
    eza
    gh
    brightnessctl
    hyprpaper
    killall
    pamixer
    glances
    spotify-tui
    spotifyd
    # Media
    ffmpeg-full
    playerctl 

    # IDEs
    neovim
    vscode
    swaylock-effects
    sddm-chili-theme
    libsForQt5.sddm
    libsForQt5.polkit-kde-agent
    
    # Ricing apps
    cava
    plymouth
    # Ricing Themes
    tokyo-night-gtk
    # Desktop
    material-icons
    xorg.xmodmap
    xorg.xset
    xorg.xsetroot
    # Hyprland deps    
    glib
    polkit
    wlogout
    wofi
    waybar
    wlsunset
    hyprland
    slurp
    grim
    wl-clipboard
    hyprpicker
    xwaylandvideobridge

    # FPV related
    betaflight-configurator
    chromium
  ];
}
