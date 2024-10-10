common:
{ self, inputs, ... }:

{
  imports = [
    common.inputs.haskell-flake.flakeModule
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
