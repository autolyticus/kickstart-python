{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  gpu_driver_libs = "/usr/lib/x86_64-linux-gnu";
  cacheFolder = "__pycache__";
in {
  # process.implementation = "process-compose";

  processes = {
    # Processes here https://devenv.sh
  };

  packages = with pkgs;
    [
      # config.languages.python.package.pkgs.pjsua2
      micromamba
      alejandra
      direnv
      nix-direnv
      nil
      yq
      jq
      just
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [nerdctl]
    ++ lib.optionals (!config.container.isBuilding) [
      # ""
    ];
  devcontainer = {enable = false;};
  enterShell = ''
    export MAMBA_ROOT_PREFIX="''${DEVENV_ROOT}/.mamba"
    # eval "$(direnv hook bash)"
    #if [ $INSIDE_CONTAINER = "1" ]; then
    #  eval "$(direnv export bash)"
    #fi
    if [ -d "$MAMBA_ROOT_PREFIX" ]; then
      eval "$(micromamba shell hook --shell=posix)"
      micromamba activate
    fi
  '';
}
