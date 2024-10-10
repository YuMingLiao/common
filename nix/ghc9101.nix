final: prev:
with final.haskell.lib;
{
  haskell = (prev.haskell or { }) // {
    packages = prev.haskell.packages // {
      ghc9101 =
        pipe
          {
            overrides =
              hfinal: hprev:
              {
              };
          }
          [
            prev.haskell.packages.ghc9101.override
            noChecks
            noHaddocks
          ];
    };

  };
}
