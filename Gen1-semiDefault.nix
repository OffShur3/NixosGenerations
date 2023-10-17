# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
#
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    #bootanimation logo
    plymouth.enable = true;
    plymouth.theme = "bgrt";
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = ["quiet" "udev.log_level=0"];
  };

  #--------------------------
  #    Seccion Network
  #--------------------------

  networking = {
    hostName = "KatyUwU"; # Define your hostname.
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    
    # Enable networking
    networkmanager.enable = true;
    
    # Open ports in the firewall.
    #firewall.allowedTCPPorts = [ ... ];
    #firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    #firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";
  
  # Select internationalisation roperties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };

  #--------------------------
  #    Seccion Services
  #--------------------------

  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Configure keymap in X11
      layout = "latam";
      xkbVariant = "";

      # Enable touchpad support (enabled default in most desktopManager).
      #libinput.enable = true;
    };
    # Enable CUPS to print documents.
    printing.enable = true;
    avahi.enable = true;
    avahi.nssmdns = true;
    # for a WiFi printer
    avahi.openFirewall = true;

    # docker
    #docker.enable = true;

    #Other services...
  };




  systemd.services.encendido = {
    enable = true;
    description = "Ejecutar curl al inicio del sistema";
    after = [ "network.target" ]; # Esperar a que la red esté disponible
    serviceConfig.ExecStart = "/run/current-system/sw/bin/curl -H tags:fire -H prio:high --silent -d 'Encendiendo la PC' ntfy.sh/laconchadetumadrebobesponjaptm > /dev/null";
    wantedBy = [ "multi-user.target" ];
  };


  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  virtualisation.docker.enable = true;
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shur3 = {
    isNormalUser = true;
    description = "Shur3";
    extraGroups = ["networkmanager" "wheel"]; # "docker" ];
    packages = with pkgs; [
      firefox

      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #vim, docker, poetry #installing python dependences
    #basics / non-graphical

    #gnome extensions
    gnomeExtensions.unite
    gnomeExtensions.blur-my-shell
    gnomeExtensions.pop-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-history
    gnomeExtensions.dash-to-panel
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.openweather
    gnomeExtensions.freon
    gnomeExtensions.desktop-cube
    gnomeExtensions.burn-my-windows
    gnome.gnome-tweaks

    #Beauty customization
    fzf
    lsd #beauty shell :)
    bat
    cava
    neofetch
    tty-clock
    gradience #colors of windows

    #Others
    wget
    git
    rclone
    xclip
    neovim
    gnumake

    #some dependences
    appimagekit
    python3

    # Apps graphical
    kitty
    keepassxc
    apple-cursor
    obsidian
    vscode
    stremio
    #jupyter

    # Trabajo
    # mailspring
    # libreoffice
    # microsoft-edge
  ];

  # nixpkgs.config.permittedInsecurePackages = [
    # "mailspring-1.11.0"
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #--------------------------
  #    Seccion Programs
  #--------------------------

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };


  nix = {
    gc.automatic = true; # delete garbage collection daily
    settings = {
      auto-optimise-store = true; # optimiza la store para ahorrar espacio
      experimental-features = ["nix-command" "flakes" ]; # "search" "nixpkgs"]; #doesn't work
    };
  };
  # Configuración para permitir paquetes no libres relacionados con Steam
  #nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #  "steam"
  #  "steam-original"
  #  "steam-run"
  #];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
