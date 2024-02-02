# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./packages.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Plymouth for graphical bootscreen
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" ];
  boot.plymouth.themePackages = with pkgs; [
    (adi1090x-plymouth-themes.override { selected_themes = [ "colorful_loop" ]; })
  ];
  boot.plymouth.theme = "colorful_loop";
  # bluetooth support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  # VBox only
  # fsck will fail under vbox and cause a boot to hang, so turn it off
  boot.initrd.checkJournalingFS = false;
  # End VBox only

  networking.hostName = "matebook";
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "sv_SE.UTF-8";

  time.timeZone = "Europe/Stockholm";
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    shellAliases = {
      vi = "nvim";

    };
  };
  users.defaultUserShell = pkgs.zsh;
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;
  programs.neovim.defaultEditor = true;
  #programs.nylas-mail.enable = true;
  programs.npm.enable = true;
  programs.nm-applet.enable = true;
  programs.less.enable = true;
  #programs.iotop.enable = true;
  programs.iftop.enable = true;
  programs.java.enable = true;
  services.mpd = {
    enable = true;
    startWhenNeeded = true;
  };

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  services.acpid.enable = true;
  location.latitude = 63.825848;
  location.longitude = -20.263035;

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;

  services.printing.enable = true;

  sound.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
};

  services.xserver.enable = true;
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.displayManager.sddm = {
      enable = true;
      theme = "chili";
  };
  services.xserver.libinput.enable = true;
  services.xserver.layout = "se";
  services.xserver.xkbVariant = "mac";
  
  # Enable i3 window manager
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    polybar
    dmenu
  ];
  services.redshift.enable = true;
  services.picom = {
    enable = true;
  };
 
  systemd.user.services.picom.serviceConfig.ExecStart = lib.mkForce ''
    ${pkgs.picom}/bin/picom --config /home/elias/.config/picom/picom.conf
  '';
  programs.i3lock.enable = true;
  programs.i3lock.package = pkgs.i3lock-color;

  # Don't forget to set a password with ‘passwd’.
  users.users.elias = {
    isNormalUser = true;
    description = "Elias Renman";
    home = "/home/elias";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  # Login configuration
  security.pam.services.swaylock = {};
  security.polkit.enable = true;
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09";  

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  #Spotify ports for google chromecasts and mobile phones
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  # automatically connect to monitors
  services.autorandr = {
    enable = true;
    # profiles = {
    #   "laptop" = {
    #      fingerprint = {
    #       eDP1 = "<EDID>";
    #       # DP1 = "<EDID>";
    #     };
    #     config = {
    #       eDP1 = {
    #         enable = true;
    #       };
    #     #   DP1 = {
    #     #     enable = true;
    #     #     crtc = 0;
    #     #     primary = true;
    #     #     position = "0x0";
    #     #     mode = "3840x2160";
    #     #     gamma = "1.0:0.909:0.833";
    #     #     rate = "60.00";
    #     #     rotate = "left";
    #     # };
    #   }
    # };
  };
}
