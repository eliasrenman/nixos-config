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
    firefox
    google-chrome
    alacritty

    # CLI Tools
    neofetch
    bat
    exa
    # Media
    ffmpeg-full
    

    # IDEs
    neovim
    vscode
    # Hyprland deps
    waybar
    wofi
    # Ricing apps
    spotify-qt
    cava
    # Ricing Themes
    tokyo-night-gtk
    # Desktop
    material-icons
   
    vlc
    xorg.xmodmap
    xorg.xset
    xorg.xsetroot
    
    
    hyprland

    # Fonts
    
    terminus_font
    terminus_font_ttf
    jetbrains-mono
    inriafonts
    powerline-fonts
  ];
}
