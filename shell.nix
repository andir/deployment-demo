{ pkgs ? import ./nix/nixpkgs.nix {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [ niv arion crate2nix ];
}
