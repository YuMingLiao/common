# To use this package set in your `haskell-flake` projects, set the
# `basePackages` option as follows:
#
# > basePackages = config.haskellProjects.ghc9101.outputs.finalPackages;
#
{
  perSystem =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      _module.args.pkgs = import inputs'.nixpkgs {
        inherit system;
        #config.allowUnfree = true;
        overlays = [ (import ./haskell-lib.nix) ];
      };

      haskellProjects.ghc965 = {
        projectFlakeName = "YuMingLiao:common";

        # This is not a local project, so disable those options.
        defaults.packages = { };
        devShell.enable = false;
        autoWire = [ ];

        basePackages = pkgs.haskell.packages.ghc965;
        #        otherOverlays = [
        #          (final: prev: { foo = ; })
        #        ];
      };
    };
}
