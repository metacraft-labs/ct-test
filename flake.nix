{
  description = "CodeTracer test framework (ct-test): TestBinary interface + per-framework adapters";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        nim = pkgs.nim;
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            nim
            pkgs.just
            pkgs.gcc
          ];
        };
      });
}
