{
  description = "Holos - Holistic platform manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        
        rustToolchain = pkgs.rust-bin.stable.latest.default;

      in {
        packages.default = pkgs.rustPlatform.buildRustPackage {
          pname = "holos";
          version = "0.97.2";  # Current version as of the documentation

          src = pkgs.fetchFromGitHub {
            owner = "holos-run";
            repo = "holos";
            rev = "v0.97.2";  # Use the specific version tag
            sha256 = ""; # You'll need to replace this with the actual hash
          };

          cargoLock = {
            lockFile = "${self}/Cargo.lock";
            outputHashes = {
              # Add any private dependencies here if needed
            };
          };

          nativeBuildInputs = with pkgs; [
            rustToolchain
            pkg-config
          ];

          buildInputs = with pkgs; [
            openssl
          ];

          doCheck = true;  # Run tests during the build
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustToolchain
            pkg-config
            openssl
          ];
        };
      }
    );
}