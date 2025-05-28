common:
{ self, inputs, ... }:

{
  imports = [
    common.inputs.haskell-flake.flakeModule
    ./nix/ghc965.nix
  ];
  perSystem = { self', system, inputs', lib, ... }: {

# it causes downstream flake needs an input nixpkgs in perSystem  
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      #config.allowUnfree = true;
      overlays = [
        ./haskell-lib.nix
      ];
    };
  };
}
