{ pkgs ? import ./nix/nixpkgs.nix { overlays = [ (import ./packages.nix) ]; } }:
{
  inherit (pkgs)
    my_service
    slides
    ;
  tests = pkgs.callPackage ./tests.nix {};
}
