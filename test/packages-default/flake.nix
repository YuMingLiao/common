{
  description = "don't eat packages.default, common!";

  inputs = {
    common.url = "github:YuMingLiao/common";
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

          packages.default = pkgs.hello;
        };
    };
}
