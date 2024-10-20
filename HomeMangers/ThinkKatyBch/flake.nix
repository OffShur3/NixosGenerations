{
  description = "Home Manager configuration of ThinkKatyBch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { nixpkgs, zen-browser, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      zenBrowserPkg = zen-browser.packages.${system}.default;  # Puedes cambiar 'default' a 'specific' o 'generic'
    in {
      homeConfigurations."ThinkKatyBch" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];

        extraSpecialArgs = {
          zen-browser = zenBrowserPkg;
        };
      };
    };
}
