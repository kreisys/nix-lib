{ lib, runCommand, git, cleanSourceWith }:

import (builtins.fetchurl {
    url = "https://raw.githubusercontent.com/input-output-hk/haskell.nix/39914630438b7ee3ff244f39f6cf9bdbc337557f/lib/clean-git.nix";
    sha256 = "096m08a4isk4fqc2cpz3bh3hg38765gqwfb9z57gwwxsdihxl6j1";
}) {
    inherit lib runCommand git cleanSourceWith;
  }
