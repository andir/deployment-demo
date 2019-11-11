{ nixpkgs ? ./nix/nixpkgs.nix }:
let
  overlay = self: super: {
    my_service = self.callPackage ./my_service {};
    slides = self.callPackage ./slides {};
  };
  pkgs = import nixpkgs { overlays = [ overlay ]; };
in {
  inherit pkgs;
  packages = {
    inherit (pkgs) my_service slides;
  };
  tests = pkgs.callPackage ./tests.nix {};
}
