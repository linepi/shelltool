line_exist_in_file() {
(
	line=$1
	file=$2
	cat file | grep "$line"
)
}

if ! [[ -f ~/.fzf.bash ]] || ! [[ -d ${__SHELLTOOL_DIR}/.fzf ]]; then
	if ! [[ -d ${__SHELLTOOL_DIR}/.fzf ]]; then
		git clone --depth 1 https://github.com/junegunn/fzf.git ${__SHELLTOOL_DIR}/.fzf
	fi
	yes | ${__SHELLTOOL_DIR}/.fzf/install
	[ -f ~/.fzf.${shellname} ] && source ~/.fzf.${shellname}
	if line_exist_in_file "[ -f ~/.fzf.${shellname} ] && source ~/.fzf.${shellname}" $rcfile; then
		echo "[ -f ~/.fzf.${shellname} ] && source ~/.fzf.${shellname}" >> $rcfile
	fi
	
fi

if ! [[ -s ~/.autojump/etc/profile.d/autojump.sh ]] || ! [[ -d ${__SHELLTOOL_DIR}/.autojump ]]; then
	if ! [[ -d ${__SHELLTOOL_DIR}/.autojump ]]; then
		git clone https://github.com/wting/autojump.git ${__SHELLTOOL_DIR}/.autojump
	fi
	cd ${__SHELLTOOL_DIR}/.autojump
	./install.py
	cd -
	[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
	if line_exist_in_file "[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh" $rcfile; then
		echo "[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh" >> $rcfile
	fi
fi


if [[ "$(uname -m)" == "x86_64" ]] && ! [[ -f /usr/local/bin/viddy ]]; then
	mkdir ${__SHELLTOOL_DIR}/viddy
	wget -O viddy.tar.gz https://github.com/sachaos/viddy/releases/download/v0.3.6/viddy_0.3.6_Linux_x86_64.tar.gz 
	tar xf viddy.tar.gz --directory=${__SHELLTOOL_DIR}/viddy
	sudo mv ${__SHELLTOOL_DIR}/viddy/viddy /usr/local/bin 
	rm viddy.tar.gz
	rm -rf ${__SHELLTOOL_DIR}/viddy
fi
alias watch='viddy'

