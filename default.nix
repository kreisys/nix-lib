{ pkgs }:

import ./lib { inherit pkgs; inherit (pkgs) lib; }
