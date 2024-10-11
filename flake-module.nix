common:
{ self, inputs, ... }:

{
  imports = [
    common.inputs.haskell-flake.flakeModule
    common.inputs.flake-parts.flakeModule
    ./nix/ghc9101.nix
  ];
  perSystem = { self', system, inputs', lib, ... }: {
  
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      #config.allowUnfree = true;
      overlays = [
      ];
    };
  };
}
