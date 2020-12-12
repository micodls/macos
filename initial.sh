#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

brew install git

mkdir ~/Personal
pushd ~/Personal
git clone https://micodls@bitbucket.org/micodls/macos.git
pushd macos/
git config --local user.name "Mico de los Santos"
git config --local user.email "mico.dlsantos@gmail.com"
./personal.sh # run personal install scripts
popd
popd