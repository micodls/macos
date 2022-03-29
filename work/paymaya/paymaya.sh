function initialize {
    mkdir ~/Work/paymaya
}

function install_work_tools {
    brew install --cask microsoft-outlook
    brew install --cask microsoft-teams
    # set to Dark Mode
    brew install --cask microsoft-excel
    brew install --cask postman
    # set to Dark Mode
    brew install --cask docker

    brew install awscli
    # aws configure
    brew install plantuml
    brew install ossp-uuid
    # brew install openconnect -- uncomment for hackintosh
    # TODO: make bash/macro for this
    # references: https://medium.com/@edgar/use-openconnect-as-a-replacement-for-cisco-anyconnect-vpn-client-in-mac-36eab0812718
    # command: sudo openconnect --authgroup=OnePaymaya_VPN --user=mico.delossantos vpn.corp.voyager.ph
    brew install go
}

function update_git_config {
    for directory in `find $1 -maxdepth 1 -mindepth 1 -type d`; do
        pushd $directory
        if [ -d .git ]; then
            git config --local user.name "Paolo Miguel M. de los Santos"
            git config --local user.email "mico.delossantos@paymaya.com"
        fi;
        popd
    done
}

# work tools
function tools_dependencies {
    brew install python # python 3
    brew install pipenv
    brew install adoptopenjdk # java
    brew install jmeter
}

function checkout_tools {
    git clone git@code.corp.voyager.ph:Hatch/boost/nodejs-utils.git
    git clone git@code.corp.voyager.ph:chris.bello/mock-api.git
    git clone git@code.corp.voyager.ph:mico.delossantos/auto-burndown.git
    git clone git@code.corp.voyager.ph:mico.delossantos/generate_artifacts.git
    git clone git@code.corp.voyager.ph:mico.delossantos/scripts.git
    git clone git@code.corp.voyager.ph:chris.bello/onboarding.git
}

function tools {
    tools_dependencies
    mkdir ~/Work/paymaya/tools
    pushd ~/Work/paymaya/tools
    checkout_tools
    update_git_config $(pwd)
    popd
}

# boost platform
function boost_dependencies {
    brew install node
    brew install openssl
    brew install gnupg

    if ! [ -d ~/.nvm ]; then
        brew install nvm
        mkdir ~/.nvm
        echo 'export NVM_DIR="$HOME/.nvm"
        [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zshrc
        source ~/.zshrc
        nvm install --lts 8
        nvm install --lts 10
        nvm install --lts 12
        nvm alias default 12
    fi

    if ! [ -x "$(command -v mysql)" ]; then
        brew install mysql@5.7
        brew services start mysql@5.7
        brew link mysql@5.7 --force
        # setup using mysqladmin
        # should run using mysql -u root -p
    fi

    if ! [ -x "$(command -v redis-cli)" ]; then
        brew install redis
        brew services start redis
        # check using redis-cli
    fi
}

function checkout_boost_repositories {
    git clone git@gitlab.corp.paymaya.com:core/growth/boost/boost.git
    git clone git@gitlab.corp.paymaya.com:core/growth/boost/boost-adhoc.git
    git clone git@gitlab.corp.paymaya.com:core/growth/boost/boost-callback-fetcher.git
    git clone git@gitlab.corp.paymaya.com:core/growth/boost/boost-database-fetcher.git
    git clone git@gitlab.corp.paymaya.com:core/growth/boost/boost-offline-earn-processor.git
    git clone git@gitlab.corp.paymaya.com:core/growth/boost/boost-reports-generator.git
    git clone git@gitlab.corp.paymaya.com:core/growth/boost/boost-rewards-fetcher.git
    git clone git@gitlab.corp.paymaya.com:core/growth/boost/boost-spiels-fetcher.git
    git clone git@gitlab.corp.paymaya.com:core/growth/boost/lambda-boost-cache-brand-regex.git
    git clone git@gitlab.corp.paymaya.com:core/growth/boost/lambda-boost-cleanup.git
    git clone git@gitlab.corp.paymaya.com:mico.delossantos/cheat-sheet.git
}

function setup_boost {
    # pushd ~/Work/paymaya/boost-platform/boost
    # npm login
    # nvm use 8
    # npm install
    generate_boost_keys
}

function generate_boost_keys {
    mkdir ~/Work/paymaya/boost-platform/boost-keys
    openssl genrsa -out ~/Work/paymaya/boost-platform/boost-keys/private.pem 2048
    openssl rsa -in ~/Work/paymaya/boost-platform/boost-keys/private.pem -outform PEM -pubout -out ~/Work/paymaya/boost-platform/boost-keys/enterprise.pem
}

function boost_platform {
    boost_dependencies
    mkdir ~/Work/paymaya/boost-platform
    pushd ~/Work/paymaya/boost-platform
    checkout_boost_repositories
    update_git_config $(pwd)
    # setup_boost
    popd
}

# audience management platform
function am_dependencies {
    brew install node
    brew install openssl

    if ! [ -d ~/.nvm ]; then
        brew install nvm
        mkdir ~/.nvm
        echo 'export NVM_DIR="$HOME/.nvm"
        [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zshrc
        source ~/.zshrc
        nvm install --lts 10
        nvm alias default 10
    fi

    if ! [ -x "$(command -v mysql)" ]; then
        brew install mysql@5.7
        brew services start mysql@5.7
        brew link mysql@5.7 --force
        # setup using mysqladmin
        # should run using mysql -u root -p
    fi

    if ! [ -x "$(command -v redis-cli)" ]; then
        brew install redis
        brew services start redis
        # check using redis-cli
    fi

    if ! [ -x "$(command -v elasticsearch)" ]; then
        brew tap elastic/tap
        brew install elastic/tap/elasticsearch-full
        brew services start elasticsearch-full
        # check using http://localhost:9200
    fi
}

function checkout_am_repositories {
    git clone git@gitlab.corp.paymaya.com:core/growth/audience-management-platform/audience-management.git
    # git clone git@code.corp.voyager.ph:chris.bello/audience-management-tester.git
}

function audience_management {
    am_dependencies
    mkdir ~/Work/paymaya/audience-management
    pushd ~/Work/paymaya/audience-management
    checkout_am_repositories
    update_git_config $(pwd)
    popd
}

# referral platform
function referral_dependencies {
    brew install node

    if ! [ -d ~/.nvm ]; then
        brew install nvm
        mkdir ~/.nvm
        echo 'export NVM_DIR="$HOME/.nvm"
        [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zshrc
        source ~/.zshrc
        nvm install --lts 12
        nvm alias default 12
    fi

    if ! [ -x "$(command -v mysql)" ]; then
        brew install mysql@5.7
        brew services start mysql@5.7
        brew link mysql@5.7 --force
        # setup using mysqladmin
        # should run using mysql -u root -p
    fi
}

function checkout_referral_repositories {
    git clone git@code.corp.voyager.ph:Hatch/boost/referral-api.git
}

function referral_platform {
    referral_dependencies
    mkdir ~/Work/paymaya/referral-platform
    pushd ~/Work/paymaya/referral-platform
    checkout_referral_repositories
    update_git_config $(pwd)
    popd
}

# promo platform
function promo_dependencies {
    brew install node
    brew install openssl

    if ! [ -d ~/.nvm ]; then
        brew install nvm
        mkdir ~/.nvm
        echo 'export NVM_DIR="$HOME/.nvm"
        [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zshrc
        source ~/.zshrc
        nvm install --lts 12
        nvm alias default 12
    fi

    if ! [ -x "$(command -v redis-cli)" ]; then
        brew install redis
        brew services start redis
        # check using redis-cli
    fi
}

function checkout_promo_repositories {
    git clone git@gitlab.corp.paymaya.com:core/growth/promo-platform/promo-analytics-fetcher.git
    git clone git@gitlab.corp.paymaya.com:core/growth/promo-platform/promo-event-subscriber.git
    git clone git@gitlab.corp.paymaya.com:core/growth/promo-platform/promo-sqs-reader.git
    git clone git@gitlab.corp.paymaya.com:core/growth/promo-platform/promo-platform.git
    git clone git@gitlab.corp.paymaya.com:core/growth/promo-platform/promo-platform-loader.git
    git clone git@gitlab.corp.paymaya.com:core/growth/cd-repositories/promo-event-subscriber-cd.git
    git clone git@gitlab.corp.paymaya.com:core/growth/cd-repositories/promo-sqs-reader-cd.git
    git clone git@gitlab.corp.paymaya.com:core/growth/cd-repositories/promo-analytics-fetcher-cd.git
}

function promo_platform {
    promo_dependencies
    mkdir ~/Work/paymaya/promo-platform
    pushd ~/Work/paymaya/promo-platform
    checkout_promo_repositories
    update_git_config $(pwd)
    popd
}

# voucher platform
function voucher_dependencies {
    brew install node

    if ! [ -d ~/.nvm ]; then
        brew install nvm
        mkdir ~/.nvm
        echo 'export NVM_DIR="$HOME/.nvm"
        [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zshrc
        source ~/.zshrc
        nvm install --lts 10
        nvm alias default 10
    fi

    if ! [ -x "$(command -v psql)" ]; then
        brew install postgres
        brew services start postgresql
        createdb `whoami`
        createuser -s postgres
    fi
}

function checkout_voucher_repositories {
    git clone git@gitlab.corp.paymaya.com:core/growth/voucher-platform/voucher-api.git
    git clone git@gitlab.corp.paymaya.com:core/growth/voucher-platform/voucher-worker.git
}

function setup_voucher {
    # pushd ~/Work/paymaya/voucher-platform/voucher
    # npm login
    # nvm use 10
    # npm install
    generate_voucher_keys
}

function generate_voucher_keys {
    mkdir ~/Work/paymaya/voucher-platform/voucher-keys
    openssl genrsa -out ~/Work/paymaya/voucher-platform/voucher-keys/private.pem 2048
    openssl rsa -in ~/Work/paymaya/voucher-platform/voucher-keys/private.pem -outform PEM -pubout -out ~/Work/paymaya/voucher-platform/voucher-keys/enterprise.pem
}

function voucher_platform {
    voucher_dependencies
    mkdir ~/Work/paymaya/voucher-platform
    pushd ~/Work/paymaya/voucher-platform
    checkout_voucher_repositories
    update_git_config $(pwd)
    # setup_voucher
    popd
}

# initialize
# install_work_tools
# should be connected to vpn, pubkey must be uploaded to gitlab
# tools
# boost_platform
# audience_management
# referral_platform
# promo_platform
# voucher_platform