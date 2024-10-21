{ config, pkgs, ... }:

{

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  boot.initrd.kernelModules = [ "wl" ];

  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

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
}
