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
      haskellProjects.ghc9101 = {
        projectFlakeName = "YuMingLiao:common";

        # This is not a local project, so disable those options.
        defaults.packages = { };
        devShell.enable = false;
        autoWire = [ ];

        # Uses GHC-9.10.1 package set as base

        # We use a versioned package-set instead of the more
        # general `pkgs.haskellPackages` set in order to be
        # more explicit about our intentions to use a
        # specific GHC version and by extension the related
        # packages versions that come with this snapshot

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
              pkgs'.haskell.packages.ghc9101.override
              noChecks
              noHaddocks
            ];

        packages = {
          # Dependencies from Hackage
        };

        settings =
          {
          };
      };
    };
}
