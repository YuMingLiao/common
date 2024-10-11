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
      final: prev: ({
        mkDerivation =
          args:
          prev.mkDerivation (
            args
            // {
              doHaddock = false;
            }
          );
      })
    ));
  noChecks =
    hp:
    (properExtend hp (
      final: prev: ({
        mkDerivation =
          args:
          prev.mkDerivation (
            args
            // {
              doCheck = false;
            }
          );
      })
    ));
  runHPACK = drv: prev.stdenv.mkDerivation {
    name = drv.name + "hpacked-source";
    src = drv.src;
    buildInputs = [prev.haskellPackages.hpack];
    buildPhase = ''
      hpack
      cp . $out 
    '';
in

{
  haskell = (prev.haskell or { }) // {
    lib = (prev.haskell.lib or { }) // {
      inherit noHaddocks;
      inherit noChecks;
      inherit properExtend;
    };
  };
  lib = (prev.lib or {}) // {
    runHPack = runCommand
  };
}
