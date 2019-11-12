{ sources }:
final: super: {
  inherit (super.callPackage sources.niv {}) niv;
  inherit (super.callPackage sources.arion {}) arion;
  crate2nix = super.callPackage sources.crate2nix {};

  nixops = super.writeScriptBin "nixops" ''
    #!${final.stdenv.shell}
    export NIX_PATH=nixpkgs=${final.path}
    exec ${super.nixops}/bin/nixops $@
  '';
}
