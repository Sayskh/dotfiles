{
  description = "NixOS — Material Design 3 on MangoWC";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # CachyOS Kernel (DO NOT follow nixpkgs)
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    mangowc = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };


    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-cachyos-kernel,
    mangowc,
    quickshell,
    zen-browser,
    spicetify-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    vars = import ./vars.nix;

    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs vars;};
      modules = [
        {nixpkgs.overlays = [overlay-unstable];}

        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs vars;};
            users.${vars.username} = import ./home.nix;
          };
        }
      ];
    };
  };
}
