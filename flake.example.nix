{
  description = "Flake del Trabajo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default =
      pkgs.mkShell
      {
        buildInputs = [
          pkgs.python310Packages.pyautogui
          # pkgs.mailspring
          # pkgs.libreoffice
          # pkgs.microsoft-edge
          # pkgs.python3
        ];
        shellHook = ''
          #python3 ./MACRO_entrada-de-materiales.py
          PS1="\[\033[1;32m\]\342\224\214\342\224\200\$([[ \$() == *\"10.\"* ]] && echo \"[\[\033[1;34m\]\$()\[\033[1;32m\]]\342\224\200[\[\033[1;37m\]\$(/opt/vpnbash.sh)\[\033[1;32m\]]\342\224\200\")[\[\033[1;37m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h\[\033[1;32m\]]\342\224\200[\[\033[1;37m\]\w\[\033[1;32m\]]\n\[\033[1;32m\]\342\224\224\342\224\200\342\224\200\342\225\274 [\[\e[01;33m\]Trabajo\[\e[01;32m\]]\\$ \[\e[0m\]"
          echo   ""
          printf "\e[3;34m-- Bienvenido a la flake del Trabajo --\e[0m\n"
          echo   ""
        '';
      };
  };
}
