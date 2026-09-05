{
  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      createSystem =
        name:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            pkgs-unstable = unstable;
          };
          modules = [
            ({ ... }: {
              networking.hostName = name;
            })
            ./systems/${name}.nix
          ];
        };

    in
    {
      nixosConfigurations = {
        windows = createSystem "windows";
        desktop = createSystem "desktop";
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-kernel.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    noctalia.url = "github:noctalia-dev/noctalia";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    # Personal prism launcher fork
    # with few modifications
    prism-launcher.url = "github:absintheg/prism-launcher/develop";
    prism-launcher.flake = false;
  };
}
