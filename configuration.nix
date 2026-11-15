# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./packages.nix
  ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot = {
    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    # loader.timeout = 0;
    loader = {
          grub = {
    enable = true;
    device = "nodev"; # "nodev" is used for UEFI
    efiSupport = true;
  };
  efi.canTouchEfiVariables = true;
    };
  };
  
  xdg.mime.defaultApplications = {
    "application/pdf" = "/run/current-system/sw/share/applications/zen-beta.desktop";
  };
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "snezhinka" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/tailscale set --exit-node=";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/tailscale set --exit-node=";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/wrappers/bin/sudo /run/current-system/sw/bin/hx /etc/nixos/flake.nix";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/tailscale set --exit-node=server";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."snezhinka" = {
    isNormalUser = true;
    description = "Snezhinka";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.tailscale.enable = true;
  # List packages installed in system profile. ARE IN PACKAGES.NIX
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.snezhinka = import ./home.nix;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      curl
      glib
      libGL
      libxkbcommon
      fontconfig
      freetype
      dbus
    ];
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  #     programs.iio-hyprland.enable = true;
  hardware.sensor.iio.enable = true;
  programs.brain-shell = {
    enable = true;
    configFormat = "lua";
  };
  programs.zsh.enable = true;
  programs.iio-hyprland.enable = true;
  programs.zsh = {
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  # users.users.snezhinka.shell = pkgs.zsh;
  users.defaultUserShell = pkgs.zsh;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
