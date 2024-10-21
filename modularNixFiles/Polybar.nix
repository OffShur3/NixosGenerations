# Polybar Config
{ config, pkgs }

{
  
  environment.systemPackages = with pkgs; [
    # --Polybar--
    polybar
    xorg.xbacklight
    wmctrl
    playerctl
    feh
    jq
    libnotify
    eww
    xdotool
    playerctl
    brightnessctl
    pulseaudioFull
    # -----------

  ]
}
