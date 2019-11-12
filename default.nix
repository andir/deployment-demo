{ pkgs ? import ./nix/nixpkgs.nix { overlays = [ (import ./packages.nix) ]; } }:
{
  inherit (pkgs)
    my_service
    slides
    ;
    tests = pkgs.callPackage ./tests.nix {};
    deploymentScript = pkgs.callPackage ./deployment.nix {
      targets = [ "user@192.168.122.192" ];
    };
}
