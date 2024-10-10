{
  description = "my common flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
    nixpkgs-24_05.url = "github:nixos/nixpkgs/nixos-24.05"; # Used for my nixos
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{ self, nixpkgs, ...}:
    let
      overlayed-nixpkgs = nixpkgs.legacyPackages.x86_64-linux.appendOverlays [self.overlay.default];
    in
    {
      overlay.default = import ./haskell-lib.nix;
      #defaultPackages.x86_64-linux = overlayed-nixpkgs;
      legacyPackages.x86_64-linux = overlayed-nixpkgs;
      lib.mkFlake =
        args: mod:
        inputs.flake-parts.lib.mkFlake
          {
            inputs = args.inputs // {
              inherit (inputs) nixpkgs;
            };
          }
          {
            systems = import inputs.systems;
            imports = [
              inputs.haskell-flake.flakeModule
            ];
          };
    };
}
