{
  description = "mylib flake";

  inputs = {
  };

  outputs = { self, nixpkgs }: {
    overlay.default = import ./haskell-lib.nix;
    defaultPackages.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.hello;
  };
}
