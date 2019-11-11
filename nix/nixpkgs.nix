{ overlays ? [] }:
let
  sources = import ./sources.nix;
  overlay = import ./overlay.nix { inherit sources; };
in
  import sources.nixpkgs {
    overlays = [ overlay ] ++ overlays;
  }
