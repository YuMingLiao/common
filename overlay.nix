final: prev:

let

  # A proper prev.haskellPackage.extend that fixes
  # https://github.com/NixOS/nixpkgs/issues/26561.
  #
  # Note that f takes final: prev: arguments, scoped within the
  # Haskell package set hp.

  properExtend =
    hp: f:
    hp.override (oldArgs: {
      overrides = prev.lib.composeExtensions (oldArgs.overrides or (_: _: { })) f;
    });

  ## Sometimes you don't want any haddocks to be generated for an
  ## entire package set, rather than just a package here or there.
  noHaddocks =
    hp:
    (properExtend hp (
      final: prev: ({ mkDerivation = args: prev.mkDerivation (args // { doHaddock = false; }); })
    ));
  noChecks =
    hp:
    (properExtend hp (
      final: prev: ({ mkDerivation = args: prev.mkDerivation (args // { doCheck = false; }); })
    ));

in

{
  haskell = (prev.haskell or { }) // {
    lib = (prev.haskell.lib or { }) // {
      inherit noHaddocks;
      inherit noChecks;
      inherit properExtend;
    };

    packages = prev.haskell.packages // {
      ghc965 = prev.haskell.packages.ghc965.override {
        overrides = hfinal: hprev: {
          ghc = prev.haskell.lib.dontHaddock hprev.ghc;
        };
        
      };
      #ghc965 = prev.lib.pipe { overrides = hfinal: hprev: { }; } [
        #prev.haskell.packages.ghc965.override
        #final.haskell.lib.noChecks
        #final.haskell.lib.noHaddocks
      #];
    };
#    compiler = prev.haskell.compiler // {
#      ghc965 = prev.haskell.lib.dontHaddock prev.haskell.compiler.ghc965;
#  };
}
