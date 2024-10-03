{
  description = "mylib flake";

  inputs = {
  };

  outputs = { self, nixpkgs }: {
    lib = {
            haskell = import ./my-haskell-lib.nix { inherit nixpkgs; };
          };
  };
}
