{
  outputs = { self, nixpkgs }:
    let forAllSystems = f:
          nixpkgs.lib.genAttrs
            (builtins.attrNames nixpkgs.legacyPackages)
            (system: f {
              inherit system;
              pkgs = nixpkgs.legacyPackages.${system};
            });
    in {
      devShells = forAllSystems ({ system, pkgs }: {
        default = pkgs.mkShell {
          packages = [
            (pkgs.sbcl.withPackages (pkgs: with pkgs; [
              alexandria cl-ppcre trivia trivia_dot_ppcre
            ])
            )
          ];
          shellHook = ''
            export CL_SOURCE_REGISTRY=`pwd`
          '';
        };
      });
    };
}
