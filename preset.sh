if [[ "$HOME" != "/root" ]]; then
    alias sudo='sudo '
    alias apt='sudo apt'
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
osinstall tmux
cp $__SHELLTOOL_DIR/.tmux.conf ~/.tmux.conf

if ! command_exists nvim; then
    if ! command_exists add-apt-repository; then
        osinstall software-properties-common
    fi
    if ! command_exists gcc; then
        osinstall build-essential
    fi
    osinstall unzip
    yes | sudo add-apt-repository ppa:neovim-ppa/unstable
    yes | sudo apt update
    osinstall neovim
    osinstall ripgrep
    mkdir -p ~/.config
    cp -r $__SHELLTOOL_DIR/nvim ~/.config
fi
alias vim='nvim'
alias vi='nvim'
