{
  description = "NixOS configuration of Ryan Yin";


  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      # Replace the official cache with a mirror located in China
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];

    extra-substituters = [
      # Nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # ...

  inputs = {
    # ...
    # Helix editor, using version 23.05
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations = {
      KatyUwU = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # Set all input parameters as specialArgs of all sub-modules
        # so that we can use the `helix`(an attribute in inputs) in
        # sub-modules directly.
        specialArgs = inputs;
        modules = [
          ./Gen1-semiDefault.nix
        ];
      };
    };
  };
}
