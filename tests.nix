{ callPackage }:
{
  my_package = callPackage ./my_service/tests.nix {};
}
