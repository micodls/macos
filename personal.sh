function generate_pub_key {
    if ! [ -f ~/.ssh/id_rsa.pub ]; then
        ssh-keygen -t rsa
    fi

    # copy ~/.ssh/id_rsa.pub to bitbucket/github Account SSH Keys -- for personal
    # copy ~/.ssh/id_rsa.pub to gitlab Account SSH Keys -- for paymaya
}

function install_applications {
    brew tap homebrew/cask
    brew tap homebrew/cask-versions

    brew install --cask authy
    # needs authentication from other installed app (mobile/pc)
    brew install --cask lastpass
    brew install --cask visual-studio-code
    # sync settings using extension: settings sync
    # restart needed to use zsh as default terminal
    # create separate workspaces for Personal and Work
    brew install --cask evernote
    brew install --cask spotify
    brew install --cask google-chrome-canary
    brew install --cask telegram
    brew install --cask vlc
    brew install --cask android-file-transfer

    brew install mas
    # mas install 408981434 # imovie
    # mas install 497799835 # xcode
    # sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
    # mas install 1451544217 # lightroom
}

generate_pub_key
install_applications