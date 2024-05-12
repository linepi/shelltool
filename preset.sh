if [[ "$HOME" != "/root" ]]; then
    alias sudo='sudo '
    alias apt='sudo apt'
    alias yum='sudo yum'
    alias docker='sudo docker'
else
    alias sudo=''
fi

command_exists() {
    command -v "$@" > /dev/null 2>&1
}

_osinstall() {
    if command_exists apt; then
        yes | sudo apt install $@
    elif command_exists yum; then
        sudo yum install -y $@
    elif command_exists brew; then
        brew install $@
    else
        echo 'no osinstall method found'
    fi
}

osinstall() {
    if ! command_exists $1; then
        _osinstall $@
    fi
}

osinstall wget
osinstall curl
osinstall python3
if ! command_exists tmux; then
    osinstall tmux
    cp $__SHELLTOOL_DIR/.tmux.conf ~/.tmux.conf
fi

if ! command_exists nvim; then
    if command_exists apt; then
        if ! command_exists add-apt-repository; then
            osinstall software-properties-common
        fi
        yes | sudo add-apt-repository ppa:neovim-ppa/unstable
        yes | sudo apt update
        osinstall ripgrep
    elif command_exists yum; then
        osinstall yum-utils
        sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
        osinstall ripgrep
    fi
    if ! command_exists gcc; then
        osinstall build-essential
    fi

    osinstall unzip
    osinstall neovim
    mkdir -p ~/.config
    cp -r $__SHELLTOOL_DIR/nvim ~/.config
else
    alias vim='nvim'
    alias vi='nvim'
fi
