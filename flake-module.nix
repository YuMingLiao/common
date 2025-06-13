common:
{ self, inputs, ... }:

{
  imports = [
    common.inputs.haskell-flake.flakeModule
    ./nix/ghc9101.nix
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
      devShell = {
        tools = hp: {
          haskell-language-server = null;
          hlint = null;
        };

        hoogle = false;
        #hlsCheck.enable = false;
      };

    };
}
