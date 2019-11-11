let inherit (import ./default.nix {}) packages pkgs; in
pkgs.mkShell {
  buildInputs = with pkgs; [ niv arion crate2nix ];
}
