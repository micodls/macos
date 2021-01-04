#!/usr/bin/env bash

function install_homebrew {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update
}

function update_git_config {
    for directory in `find $1 -maxdepth 1 -mindepth 1 -type d`; do
        pushd $directory
        if [ -d .git ]; then
            git config --local user.name "Mico de los Santos"
            git config --local user.email "mico.dlsantos@gmail.com"
        fi;
        popd
    done
}

function install_dependencies {
    brew install git
}

function checkout_personal_repositories {
    git clone https://micodls@bitbucket.org/micodls/macos.git
}

function initialize_personal {
    install_dependencies
    mkdir ~/Personal
    pushd ~/Personal
    checkout_personal_repositories
    update_git_config $(pwd)
    popd
}

function run_personal_setup {
    pushd ~/Personal/macos
    ./personal.sh
    popd
}

function initialize_work {
    install_dependencies
    mkdir ~/Work
    pushd ~/Work
    ~/Personal/macos/work/paymaya/paymaya.sh
    popd
}

initialize_work