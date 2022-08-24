{ pkgs, defaultSource, apps }:
let
  rust = pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  };

  clientSource = "${defaultSource}/client";
  clientDependencies = with pkgs; [
    yarn rnix-lsp nixpkgs-fmt
  ];

  serverSource = "${defaultSource}/server";
  serverDependencies = with pkgs; [
    rust rust-analyzer rustfmt
    rnix-lsp nixpkgs-fmt
    pkg-config openssl
    postgresql
  ];
in {
  devShells = {
    client = import ./client.nix {
      inherit pkgs clientSource clientDependencies;
    };

    server = import ./server.nix {
      inherit pkgs serverSource serverDependencies;
    };

    default = pkgs.mkShell {

      buildInputs = with pkgs; [
        haskell-language-server
        rnix-lsp nixpkgs-fmt
        geos gdal
        (postgresql.withPackages (p: [ p.postgis ]))
        (haskellPackages.ghcWithPackages (self: with haskellPackages; [
          effectful curl xml tar zlib megaparsec bytestring directory tmp-postgres json process hlint
        ]))

        apps.clean-archive-backups
        apps.download-archive-dump
        apps.run-temp-database
        apps.run-end-to-end
        apps.run-archive-node
        apps.run-archive-database

        deploy-rs
      ];

      shellHook = ''
        runghc Tools/downloadArchiveDump.hs
      '';
    };
  };
}