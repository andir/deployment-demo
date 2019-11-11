{ pkgs ? import ./nix/nixpkgs.nix {} }:
{
  my_service = pkgs.callPackage ./my_service {};
  slides = pkgs.callPackage ./slides {};
  tests = pkgs.callPackage ./tests.nix {};
}
