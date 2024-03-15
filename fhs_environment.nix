{ pkgs ? import <nixpkgs> {}}:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "fhs_environment";

    targetPkgs = _: [
      pkgs.micromamba
    ];

    profile = ''
      set -e
      eval "$(micromamba shell hook --shell=posix)"
      export MAMBA_ROOT_PREFIX=${builtins.getEnv "PWD"}/.mamba
      set +e
    '';
  };
in fhs.env
