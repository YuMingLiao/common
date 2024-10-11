{
  description = "test overlayed pkgs";

  inputs = {
    flake-parts.follows = "example/flake-parts";
    example.url ="github:YuMingLiao/haskell-flake-dependency-instance";
    haskell-flake.follows = "example/haskell-flake";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [ 
        inputs.haskell-flake.flakeModule ];
      perSystem =
        {
          self',
          config,
          pkgs,
          ...
        }:
        {
          haskellProjects.default = {
            imports = [
              inputs.example.haskellFlakeProjectModules.output
            ];
          };
          packages.default = throw "error";

        };
    };
}
