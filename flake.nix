{
  description = "Holos - Holistic platform manager";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    holos-src = {
      url = "github:holos-run/holos/v0.103.0";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, holos-src, determinate }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages.default = pkgs.buildGoModule {
          pname = "holos";
          version = "0.103.0";

          src = holos-src;

          vendorHash = "sha256-83Y69ri3zJB4S5OY1RjFlCnBlyPS2OwSTre6iQ5Zm/o=";

          subPackages = [ "cmd/holos" ];

          doCheck = false;
          
          meta = with pkgs.lib; {
            description = "Holistic platform manager";
            homepage = "https://github.com/holos-run/holos";
            license = licenses.asl20;
            maintainers = [ ];
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            gopls
            go-tools
            self.packages.${system}.default
          ];
        };
      }
    );
}