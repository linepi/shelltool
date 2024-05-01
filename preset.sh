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

osinstall() {
    if command_exists apt; then
        sudo apt install $@
    elif command_exists yum; then
        sudo yum install -y $@
    elif command_exists brew; then
        brew install $@
    else
        echo 'no osinstall method found'
    fi
}

if ! command_exists wget; then
    osinstall wget
fi

if ! command_exists curl; then
    osinstall curl
fi

if ! command_exists python3; then
    osinstall python3
fi

if ! command_exists tmux; then
    osinstall tmux
    cp $__SHELLTOOL_DIR/.tmux.conf ~/.tmux.conf
fi

if ! command_exists nvim; then
    osinstall neovim
fi
alias vim='nvim'
alias vi='nvim'
