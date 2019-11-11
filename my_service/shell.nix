let
  inherit (import ../default.nix {}) packages nixpkgs;
in nixpkgs.mkShell {
  nativeBuildInputs = with nixpkgs; [ cargo clippy ];
}
