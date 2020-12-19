{ lib, runCommand, git, cleanSourceWith }:

import (builtins.fetchurl "https://raw.githubusercontent.com/input-output-hk/haskell.nix/39914630438b7ee3ff244f39f6cf9bdbc337557f/lib/clean-git.nix") {
    inherit lib runCommand git cleanSourceWith;
  }
