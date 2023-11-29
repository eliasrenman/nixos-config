{ config, pkgs, ... }:

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
    
    rustc
    python38
    nodejs_20


    # GUI tools
    kicad-small
    xfce.thunar
    google-chrome
    alacritty
    vlc
    # CLI Tools
    neofetch
    bat
    exa
    gh
    brightnessctl
    hyprpaper
    # Media
    ffmpeg-full
    

    # IDEs
    neovim
    vscode
    # Hyprland deps
    waybar
    wofi
    libsForQt5.sddm
    wlogout
    # Ricing apps
    spotify-qt
    cava
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
