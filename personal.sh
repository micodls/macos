function generate_pub_key {
    if ! [ -f ~/.ssh/id_rsa.pub ]; then
        ssh-keygen -t rsa
    fi
}

function install_applications {
    brew tap homebrew/cask
    brew tap homebrew/cask-versions

    brew install --cask authy
    brew install --cask lastpass
    brew install --cask visual-studio-code # sync settings using extension: settings sync
    brew install --cask evernote
    brew install --cask spotify
    brew install --cask google-chrome-canary
    brew install --cask telegram
    brew install --cask vlc
    brew install --cask android-file-transfer

    brew install mas
    mas install 408981434 # imovie
    # mas install 497799835 # xcode
    # mas install 1451544217 # lightroom
}

generate_pub_key
install_applications