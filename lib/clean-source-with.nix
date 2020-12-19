{ lib, nix-gitignore }:

let
  inherit (import (builtins.fetchurl "https://raw.githubusercontent.com/input-output-hk/haskell.nix/09526c85558417de609ced98460392460b025b98/lib/clean-source-with.nix") { inherit lib; }) cleanSourceWith;
  inherit (nix-gitignore) gitignoreFilterPure;
in

{ name
, src
, subDir ? ""
, patterns ? []
, filter ? (_: _: true)
, caller ? "cleanSourceWith"
, includeSiblings ? false
}:

let
  subDir' = if subDir == "" then "" else "/" + subDir;
  srcSubDir = src + subDir';
  origSrcSubDir = src.origSrcSubDir or srcSubDir;
in

cleanSourceWith {
  inherit name src subDir caller includeSiblings;
  filter = gitignoreFilterPure filter patterns origSrcSubDir;
}
