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
  
  # Plymouth for graphical bootscreen
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" ];
  boot.plymouth.extraConfig = ''
  DeviceScale=1
  '';
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
  #programs.nm-applet.enable = true;
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
  
  # Enable the Hyprland Desktop Environment.
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  # Don't forget to set a password with ‘passwd’.
  users.users.elias = {
    isNormalUser = true;
    description = "Elias Renman";
    home = "/home/elias";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };
  # Login configuration
  security.pam.services.swaylock = {};
  security.polkit.enable = true;
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09";  
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  #Spotify ports for google chromecasts and mobile phones
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  # Nvidia driver configuration
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    prime = {
      sync.enable = true;

        # Make sure to use the correct Bus ID values for your system!
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    open = false;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  programs.hyprland.enableNvidiaPatches = true;

  environment.variables = {
    PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
  };

  
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "elias" ];

}
