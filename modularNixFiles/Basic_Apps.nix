{
  config,
  pkgs,
  ...
}:{
   
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    
    #---- Nix Tools ----
    cached-nix-shell
    gnumake
    appimagekit
    #-------------------

    # --- GNOME Shit ---
    # gnomeExtensions.unite
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.pop-shell
    # gnomeExtensions.caffeine
    # gnomeExtensions.clipboard-history
    # gnomeExtensions.dash-to-panel
    # gnomeExtensions.dash-to-dock
    # gnomeExtensions.just-perfection
    # gnomeExtensions.openweather
    #gnomeExtensions.freon # Deprecated
    # gnomeExtensions.desktop-cube
    # gnomeExtensions.burn-my-windows
    # gnome.gnome-tweaks
    # gnome-extension-manager
    #gnome.gnome-system-monitor
    #gnome.nautilus

    #-------------------
    # shell customization
    fzf
    lsd #beauty shell :)
    bat
    cava
    neofetch
    tty-clock
    # gradience #colors of windows
    btop
    pulseaudioFull
    shellcheck
    # pipes
    wget
    openvpn
    xorg.xkill #easy kill apps
    distrobox
    evillimiter
    ripgrep
    fd
    xclip
    unzip
    unrar
    nodejs
    git
    rclone
    # cli apps
    neovim
    syncthing

    #-------------------
    #some dependences
    docker-compose
    docker
    
    # programming languages
    # -PYTHON-
    python3
    # python310Packages.pyautogui
    python310Packages.pillow

    # -RUST-
    rustc
    rustup
    cargo
    mdbook

    #-------------------

    #-------------------
    # bspwm
    # sxhkd
    # picom
    dmenu
    polybar
    wmctrl
    playerctl
    feh
    rofi
    killall
    layan-gtk-theme
    clipmenu
    jq
    libnotify
    flameshot #gnome.gnome-screenshot #ojala fuese bueno
    eww
    xdotool
    playerctl
    dunst
    brightnessctl

    #-------------------
    #Others

    # Apps graphical
    easyeffects
    kitty
    keepassxc
    apple-cursor
    obsidian
    # vscode
    stremio
    discord

    # Trabajo
    mailspring
    libreoffice
    #microsoft-edge
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "mailspring-1.11.0"
    "electron-25.9.0"
  ];

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

}
