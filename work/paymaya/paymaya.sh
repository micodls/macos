function initialize {
    mkdir ~/Work/paymaya
}

function install_work_tools {
    brew install --cask microsoft-outlook
    brew install --cask microsoft-teams
    brew install --cask microsoft-excel
    brew install --cask postman

    brew install awscli
    # aws configure
    brew install plantuml
    brew install openconnect
    brew install ossp-uuid
    # TODO: make bash/macro for this
    # references: https://medium.com/@edgar/use-openconnect-as-a-replacement-for-cisco-anyconnect-vpn-client-in-mac-36eab0812718
    # sudo openconnect --authgroup=OnePaymaya_VPN --user=mico.delossantos vpn.corp.voyager.ph
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
}

function checkout_tools {
    git clone git@code.corp.voyager.ph:Hatch/boost/nodejs-utils.git
    git clone git@code.corp.voyager.ph:chris.bello/mock-api.git
    git clone git@code.corp.voyager.ph:mico.delossantos/auto-burndown.git
    git clone git@code.corp.voyager.ph:mico.delossantos/generate_artifacts.git
    git clone git@code.corp.voyager.ph:mico.delossantos/scripts.git
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
    brew install adoptopenjdk # java
    brew install gnupg

    if ! [ -d ~/.nvm ]; then
        brew install nvm
        mkdir ~/.nvm
        echo 'export NVM_DIR="$HOME/.nvm"
        [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zshrc
        source ~/.zshrc
        nvm install --lts 8
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
    git clone git@code.corp.voyager.ph:Hatch/boost/boost.git
    git clone git@code.corp.voyager.ph:Hatch/boost/boost-adhoc.git
    git clone git@code.corp.voyager.ph:Hatch/boost/boost-callback-fetcher.git
    git clone git@code.corp.voyager.ph:Hatch/boost/boost-offline-earn-processor.git
    git clone git@code.corp.voyager.ph:Hatch/boost/boost-reports-generator.git
    git clone git@code.corp.voyager.ph:Hatch/boost/boost-rewards-fetcher.git
    git clone git@code.corp.voyager.ph:Hatch/boost/boost-spiels-fetcher.git
    git clone git@code.corp.voyager.ph:Hatch/boost/lambda-boost-cache-brand-regex.git
    git clone git@code.corp.voyager.ph:Hatch/boost/lambda-boost-cleanup.git
}

function boost_platform {
    boost_dependencies
    mkdir ~/Work/paymaya/boost-platform
    pushd ~/Work/paymaya/boost-platform
    checkout_boost_repositories
    update_git_config $(pwd)
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
    git clone git@code.corp.voyager.ph:Hatch/boost/audience-management.git
    git clone git@code.corp.voyager.ph:chris.bello/audience-management-tester.git
    git clone git@code.corp.voyager.ph:Hatch/boost/lambda-customer-tags-processor.git
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
    git clone git@code.corp.voyager.ph:Hatch/boost/promo-analytics-fetcher.git
    git clone git@code.corp.voyager.ph:Hatch/boost/promo-event-subscriber.git
    git clone git@code.corp.voyager.ph:Hatch/boost/promo-sqs-reader.git
    git clone git@code.corp.voyager.ph:mico.delossantos/promo-platform.git
    git clone git@code.corp.voyager.ph:mico.delossantos/promo-platform-loader.git
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
    git clone git@code.corp.voyager.ph:Hatch/boost/voucher-api.git
    git clone git@code.corp.voyager.ph:Hatch/boost/voucher-data.git
    git clone git@code.corp.voyager.ph:Hatch/boost/voucher-worker.git
}

function voucher_platform {
    voucher_dependencies
    # mkdir ~/Work/paymaya/voucher-platform
    # pushd ~/Work/paymaya/voucher-platform
    # checkout_voucher_repositories
    # update_git_config $(pwd)
    # popd
}

# install_work_tools
# should be connected to vpn
# tools
# boost_platform
# audience_management
# referral_platform
# promo_platform
voucher_platform