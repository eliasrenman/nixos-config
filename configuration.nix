# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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

  # VBox only
  # fsck will fail under vbox and cause a boot to hang, so turn it off
  boot.initrd.checkJournalingFS = false;
  # End VBox only

  networking.hostName = "nixos";
  networking.wireless.enable = true;

  i18n.defaultLocale = "sv_SE.UTF-8";

  time.timeZone = "Europe/Stockholm";
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  program.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;
  programs.neovim.defaultEditor = true;
  #programs.nylas-mail.enable = true;
  programs.npm.enable = true;
  #programs.nm-applet.enable = true;
  programs.less.enable = true;
  #programs.iotop.enable = true;
  programs.iftop.enable = true;
  programs.java.enable = true;
  services.mpd = {
    enable = true;
    startWhenNeeded = true;
  };

  services.acpid.enable = true;
  services.redshift = {
    enable = true;
    latitude = "63.825848";
    longitude = "-20.263035";
  };

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

  services.xserver.libinput.enable = true;
  services.xserver.layout = "se";
  services.xserver.xkbVariant = "mac";

  # Enable the Hyprland Desktop Environment.
  programs.hyprland.enable = true;
  # programs.hyprland.enableNvidiaPatches = true;
  programs.hyprland.xwayland.enable = true;

  # Don't forget to set a password with ‘passwd’.
  users.users.elias = {
    isNormalUser = true;
    description = "Elias Renman";
    home = "/home/elias";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09";

  system.autoUpgrade.enable = true;

}
