__SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

__command_exists() {
	if hash $1 2>/dev/null; then
		echo true
	else
		echo false
	fi	
}

rcfile=
if [[ $SEHLL == "bash" || $(echo $0) =~ 'bash' ]]; then
	rcfile='~/.bashrc'
elif [[ $SHELL == "zsh" || $(echo $0) =~ "zsh" ]];then
	rcfile='~/.zshrc'
else 
	echo "Unknown shell type"
fi

if ! [[ -f ~/.fzf.bash ]]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ${__SCRIPT_DIR}/.fzf
	yes | ${__SCRIPT_DIR}/.fzf/install
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

if ! [[ -s ~/.autojump/etc/profile.d/autojump.sh ]]; then
	git clone https://github.com/wting/autojump.git ${__SCRIPT_DIR}/.autojump
	cd ${__SCRIPT_DIR}/.autojump
	./install.py
	cd -
	[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
	echo "[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh" >> $rcfile
fi

set -e
if ! [[ -f /usr/local/bin/viddy ]]; then
	mkdir ${__SCRIPT_DIR}/viddy
	wget -O viddy.tar.gz https://github.com/sachaos/viddy/releases/download/v0.3.6/viddy_0.3.6_Linux_x86_64.tar.gz 
	tar xf viddy.tar.gz --directory=${__SCRIPT_DIR}/viddy
	sudo mv ${__SCRIPT_DIR}/viddy/viddy /usr/local/bin 
	rm viddy.tar.gz
	rm -rf ${__SCRIPT_DIR}/viddy
fi
set +e
alias watch='viddy'
