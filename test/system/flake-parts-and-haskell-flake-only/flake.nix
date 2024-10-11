{
  description = "test overlayed pkgs";

  inputs = {
    common.url = "git+file:///home/nixos/common";
    nixpkgs.follows = "common/nixpkgs";
    typed-fsm.url ="git+file:///home/nixos/fix/typed-fsm";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      common,
      ...
    }:
    common.inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = ["x86_64-linux"];
      perSystem =
        {
          self',
          config,
          pkgs,
          system,
          ...
        }:
        {
          haskellProjects.default = {
            imports = [
              inputs.typed-fsm.haskellFlakeProjectModules.output
            ];
          };
          packages.default = throw "${system}";

        };
    };
}
