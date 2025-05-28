common:
{ self, inputs, ... }:

{
  imports = [
    common.inputs.haskell-flake.flakeModule
    ./nix/ghc965.nix
  ];
  perSystem =
    {
      self',
      system,
      inputs',
      lib,
      ...
    }:
    {

    };
  flake = {
    overlays.default = import ./overlay.nix;
  };
}
