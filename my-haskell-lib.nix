{
  nixpkgs,
  defaultSystems ? [
    "aarch64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
    "x86_64-linux"
  ]
}:

let

  # A proper prev.haskellPackage.extend that fixes
  # https://github.com/NixOS/nixpkgs/issues/26561.
  #
  # Note that f takes final: prev: arguments, scoped within the
  # Haskell package set hp.

  properExtend = hp: f: hp.override (oldArgs: {
    overrides =
    nixpkgs.lib.composeExtensions (oldArgs.overrides or (_: _: {}))
      f;
  });


  ## Sometimes you don't want any haddocks to be generated for an
  ## entire package set, rather than just a package here or there.
  noHaddocks = hp: (properExtend hp (final: prev: (
    {
      mkDerivation = args: nixpkgs.mkDerivation (args // {
        doHaddock = false;
      });
    }
  )));
  noChecks = hp: (properExtend hp (final: prev: (
    {
      mkDerivation = args: nixpkgs.mkDerivation (args // {
        doCheck = false;
      });
    }
  )));

 lib = {
  haskell.lib = { inherit noChecks noHaddocks properExtend; };
 };
in lib
