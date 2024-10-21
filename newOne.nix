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
    ./modularNixFiles/Basic_Apps.nix
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

  #--------------------------
  #    Seccion Programs
  #--------------------------


  nix = {
    gc.automatic = false; # delete garbage collection daily
    settings = {
      auto-optimise-store = true; # optimiza la store para ahorrar espacio
      experimental-features = ["nix-command" "flakes" ]; # "search" "nixpkgs"]; #doesn't work
    };
  };



  system.stateVersion = "24.05"; # Did you read the comment?
}
