{
  description = "mylib flake";

  inputs = {
  };

  outputs = { self, nixpkgs }: {
    lib = import ./my-haskell-lib.nix { inherit nixpkgs; };
  };
}
