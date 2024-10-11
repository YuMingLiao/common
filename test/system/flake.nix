{
  description = "test overlayed pkgs";

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
          packages.default = error "${system}";
        };
    };
}
