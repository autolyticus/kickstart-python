# Initialize a new local dev environment
init:
    #!/usr/bin/env bash
    # set -e
    #
    # # Install required packages
    # sudo apt-get update -y
    # sudo apt-get install -y curl git wget
    #
    # # Install Nix
    # curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --extra-conf "sandbox = false" --init none --no-confirm
    #
    # # Configure Git
    # git config --global user.email "git@govind.work"
    # git config --global user.name "Govind"
    #
    # # Install devenv and dependencies
    # nix profile install nixpkgs#direnv nixpkgs#cachix
    # cachix use devenv
    # nix profile install github:cachix/devenv/v0.6.3
    # rm -rf ~/.cache/nix
    # nix-collect-garbage --delete-old
    #
    # # Copy required files
    # cp devenv.nix devenv.lock devenv.yml .envrc .

    # Bootstrap with envrc
    # echo 'source_url "https://raw.githubusercontent.com/cachix/devenv/d1f7b48e35e6dee421cfd0f51481d17f77586997/direnvrc" "sha256-YBzqskFZxmNb3kYVoKD9ZixoPXJh1C9ZvTLGFRkauZ0="' > .envrc
    # echo 'use devenv' >> .envrc
    # direnv allow .
    # direnv exec . devenv ci

    # Create base environment
    micromamba create -y -p "$MAMBA_ROOT_PREFIX" -f env-base.yml

    # Install CUDA dependencies
    # micromamba install -y -p "/workspace/.mamba" -f env-cuda.yml

    # Install additional dependencies
    micromamba install -y -p "$MAMBA_ROOT_PREFIX" -f env.yml

    # Install pip dependencies
    uv pip install -r env-pip.txt

    # Install the pip base package
    uv pip install -e "$DEVENV_ROOT" 
