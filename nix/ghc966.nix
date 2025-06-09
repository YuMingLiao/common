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
      haskellProjects.ghc966 = {
        projectFlakeName = "YuMingLiao:common";

        # This is not a local project, so disable those options.
        defaults.packages = { };
        devShell.enable = false;
        autoWire = [ ];

        basePackages =
          let
            pkgs' = pkgs.extend (import ../overlay.nix);
          in
          with pkgs'.haskell.lib;
          with pkgs'.lib.trivial;
          pipe
            {
              overrides =
                hfinal: hprev:
                {
                };
            }
            [
              pkgs'.haskell.packages.ghc966.override
              noChecks
              noHaddocks
            ];
      };
    };
}
