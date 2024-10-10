{
  description = "test haskellProjects overlay";

  inputs = {
    common.url = "git+file:///home/nixos/common";
    nixpkgs.follows = "common/nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      common,
      ...
    }:
    common.lib.mkFlake { inherit inputs; } {
      perSystem =
        {
          self',
          config,
          pkgs,
          ...
        }:
        {
          haskellProjects.default = {
            basePackages = config.haskellProjects.ghc9101.outputs.finalPackages;
          };
          packages.default = config.haskellProjects.ghc9101.outputs.finalPackages.hello;
        };
    };
}
