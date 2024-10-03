{
  description = "mylib flake";

  inputs = {
  };

  outputs = { self, nixpkgs }: {
    overlay.default = import ./my-haskell-lib.nix;
  };
}
