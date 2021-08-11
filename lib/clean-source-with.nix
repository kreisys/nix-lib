{ lib, nix-gitignore }:

let
  inherit (import (builtins.fetchurl {
    url = "https://raw.githubusercontent.com/input-output-hk/haskell.nix/09526c85558417de609ced98460392460b025b98/lib/clean-source-with.nix";
    sha256 = "1ad16p9dlmwr8bkiz59sd70f5x33b5zcka2svfwp0c87pwv0flzw";
  }) { inherit lib; }) cleanSourceWith;
  inherit (nix-gitignore) gitignoreFilterPure;
in

{ name
, src
, subDir ? ""
, ignore ? []
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
  filter = gitignoreFilterPure filter ignore origSrcSubDir;
}
