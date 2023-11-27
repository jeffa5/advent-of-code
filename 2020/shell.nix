with import <nixpkgs> { };
let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
  rust = (nixpkgs.latest.rustChannels.stable.rust.override {
    extensions = [ "rust-src" ];
  });
  cargo-aoc = rustPlatform.buildRustPackage {
    pname = "cargo-aoc";
    version = "11.0.2";

    src = fetchFromGitHub {
      owner = "gobanos";
      repo = "cargo-aoc";
      rev = "master";
      sha256 = "1iga3320mgi7m853la55xip514a3chqsdi1a1rwv25lr9b1p7vd3";
    };

    cargoSha256 = "079aypc681jfsmkk3lizdd3m1dmpjhcpqjcnl6ws3mf6byhb1gqp";
  };
in
mkShell {
  buildInputs = [
    rust
    cargo-aoc

    rnix-lsp
    nixpkgs-fmt
  ];
}
