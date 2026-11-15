{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    iio-hyprland-lua.url = "github:ThorTuwy/lua-iio-hyprland";

    brain-shell = {
      url = "github:Brainitech/Brain_Shell?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      brain-shell,
      silentSDDM,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.snezhinka = import ./home.nix;
          }
          brain-shell.nixosModules.default

          silentSDDM.nixosModules.default

          # IIO accelerometer and Hyprland integration
          ({ pkgs, ... }: {
            hardware.sensor.iio.enable = true;

            environment.systemPackages = [
              inputs.iio-hyprland-lua.packages.${pkgs.stdenv.hostPlatform.system}.default
            ];
          })

          # SilentSDDM
          {
            programs.silentSDDM = {
              enable = true;
              theme = "silvia";

              backgrounds = {
                custom = ./wallpapers/sddm.jpg;
              };

              settings = {
                "General" = {
                  animated-background-placeholder = "sddm.jpg";
                };

                "LockScreen" = {
                  background = "sddm.jpg";
                  use-background-color = false;
                };

                "LoginScreen" = {
                  background = "sddm.jpg";
                  use-background-color = false;
                };
              };
            };
          }
        ];
      };
    };
}
