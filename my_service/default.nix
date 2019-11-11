{ callPackage }: (callPackage ./Cargo.nix {}).rootCrate.build
