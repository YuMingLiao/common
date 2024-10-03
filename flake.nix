{
  description = "mylib flake";

  inputs = {
  };

  outputs = { self, nixpkgs }: {
    haskell.lib = import ./my-haskell-lib.nix { inherit nixpkgs; };
  };
}
