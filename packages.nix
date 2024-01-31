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

    rustup
    python3
    nodejs_18
    corepack

    # GUI tools
    kicad-small
    xfce.thunar
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
    # Media
    ffmpeg-full
    playerctl 

    # IDEs
    neovim
    vscode
    # Hyprland deps
    waybar
    wofi
    libsForQt5.sddm
    libsForQt5.polkit-kde-agent
    glib
    wlogout
    swaylock-effects
    sddm-chili-theme
    polkit
    
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
    
    wlsunset
    hyprland
  ];
}
