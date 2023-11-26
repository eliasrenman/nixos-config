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
    dd


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
    python37
    nodejs_20


    # GUI tools



    # Media
    ffmpeg-full
    gstreamer
    gst-plugins-base
    gst-plugins-bad
    gst-plugins-ugly
    gst-plugins-good

    # IDEs
    neovim
    vscode

    # Desktop
    
    xmonad-with-packages
    dmenu
    rofi
    material-icons

    xorg.xmodmap
    xorg.xset
    xorg.xsetroot

    terminus_font
    terminus_font_ttf
    dejavu_fonts
    jetbrains-mono
    inriafonts
    iosevka

    firefox
    chromium
    alacritty
    hyprland
    ncmpcpp
    powerline-fonts
  ];
}
