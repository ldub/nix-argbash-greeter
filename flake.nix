{
  description = "Example greeter program that shows off writeArgbashShellApplication.";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        writeArgbashShellApplication = import ./write-argbash-shell-application.nix {
          argbash = pkgs.argbash;
          runCommandLocal = pkgs.runCommandLocal;
          writeShellApplication = pkgs.writeShellApplication;
        };
        argbash-greeter = writeArgbashShellApplication {
          name = "argbash-greeter";
          text = builtins.readFile ./argbash-greeter.m4;
          runtimeInputs = [ pkgs.cowsay ];
        };
      in rec {
        defaultPackage = argbash-greeter;
      }
    );
}