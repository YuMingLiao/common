common:
{ self, inputs, ... }:

{
  imports = [
    common.inputs.haskell-flake.flakeModule
    ./nix/ghc9101.nix
    ./nix/ghc965.nix
    ./nix/ghc984.nix
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
      haskellProjects.default = {
        devShell = {
          tools = hp: {
            haskell-language-server = null;
            hlint = null;
          };

          hoogle = false;
          #hlsCheck.enable = false;
        };
      };

    };
}
