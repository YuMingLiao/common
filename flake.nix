{
  description = "my common flake";

  inputs = {
    # Don't use nixpkgs-unstable, otherwise you will keep downloading and re-compiling haskell packages when nix flake update.
    #nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
    check-flake.url = "github:srid/check-flake";
    #nixpkgs-24_05.url = "github:nixos/nixpkgs/nixos-24.05"; # Used for my nixos
    systems.url = "github:nix-systems/default";
    #snowfall-lib = {
    #  url = "github:snowfallorg/lib";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

  };

  outputs =
    inputs@{ self, nixpkgs, ...}:
    {
      flakeModules = {
        default = import ./flake-module.nix { inherit inputs; };
      };
      lib.mkFlake =
        args: mod:
        inputs.flake-parts.lib.mkFlake
          {
            inputs = args.inputs // {
            };
          }
          {
            systems = import inputs.systems;
            imports = [
              inputs.self.flakeModules.default
              mod
            ];
          };
    };
}
