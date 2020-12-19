{ pkgs, lib }:

rec {
  /*  cleanSourceWith: Import and clean up a source tree.

    Arguments:
    - name: string.
      The name of the resulting derivation
    - src: path.
      The root of the source tree to import.
    - subDir: optional string.
      The subdirectory relative to `src` to import.
    - patterns: optional list of strings.
      Each string is a gitignore pattern which will be ignored.
    - filter: path -> string(type) -> bool.
      Filter function understood by `builtins.path`.

    `src` will be the root of the imported tree, but the relative path to
    `subDir` will be preserved. For example, given a directory tree:

      - foo
        - bar
          - baz.c
        - quux

    then `cleanSourceWith { name = "clean", src = ./foo, subDir = "bar" }`
    will yield:

      - /nix/store/00000000000000000000000000000000-clean
        - bar
          - baz.c

    For comparison, importing the same directory tree with `src = ./foo/bar`
    and `subDir` unset will yield:

      - /nix/store/00000000000000000000000000000000-clean
        - baz.c

    `patterns` are interpreted relative to `subDir`.

  */
  cleanSourceWith = import ./clean-source-with.nix {
    inherit lib;
    inherit (pkgs) nix-gitignore;
  };

  /*  cleanGit: Import and clean up a local Git repository.

    Arguments:
    - name: string.
      The name of the resulting derivation
    - src: path.
      The root of the Git repository to import.
    - subDir: optional string.
      The subdirectory relative to `src` to import.

    The relative path from `src` to `subDir` will be preserved, as
    `cleanSourceWith`.

  */
  cleanGit = import ./clean-git.nix {
    inherit lib cleanSourceWith;
    inherit (pkgs) runCommand git;
  };

  /*  cleanGit: Import and clean up a subtree of a local Git repository.

    Arguments:
    - name: string.
      The name of the resulting derivation
    - src: path.
      The root of the Git repository to import.
    - subDir: optional string.
      The subdirectory relative to `src` to import.

    Unlike `cleanSourceWith` and `cleanGit`, `cleanGitSubtree` does _not_
    preserve the relative path between `src` and `subDir`. In other words,
    `src/subDir` will be the root of the output.

  */
  cleanGitSubtree = import ./clean-git-subtree.nix {
    inherit lib cleanSourceWith;
    inherit (pkgs) runCommand git;
  };
}
