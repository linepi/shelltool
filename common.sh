COLOR_PF='\033['
COLOR_SF='m'
BLUE="${COLOR_PF}0;34${COLOR_SF}"
GREEN="${COLOR_PF}0;32${COLOR_SF}"
RED="${COLOR_PF}0;31${COLOR_SF}"
NC="${COLOR_PF}0${COLOR_SF}"

alias ..='cd ..'
alias ...='cd ../..'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias cg='cd `git rev-parse --show-toplevel`'
alias gh='history | grep'
alias rebash='. ~/.bashrc'
alias mansearch='apropos'

alias trash='mv --force -t ~/.trash'
alias trash-ls='ls ~/.trash'
alias trash-clear='rm -rf ~/.trash/*'
alias rm='rm -I --preserve-root -rf'

mcd () {
	mkdir -p $1
	cd $1	
}

killpat () {
# 通过'()'创建一个子shell
(
    if [[ "$#" -ne 1 && "$#" -ne 2 ]]; then
        echo "Usage: killpid <program name pattern> [-a]"
        return 1
    fi
    KILL_PID_ALL=$(ps aux | grep "$1" | grep -v grep)
    if [[ "$KILL_PID_ALL" == "" ]]; then
        return 0
    fi

    ans=
    while read -r KILL_PID_LINE; do
        KILL_PID=$(echo "${KILL_PID_LINE}" | awk '{print $2}')
        KILL_PROGRAM=$(echo "${KILL_PID_LINE}" | awk '{print $11}')
        KILL_PORT=$(echo "${KILL_PID_LINE}" | awk '{print $12}')
        if [[ "$#" -eq 2 && "$2" == "-a" ]]; then
            echo "Killing ${GREEN}$KILL_PROGRAM $KILL_PORT${NC}($KILL_PID)"
            sudo kill -9 "$KILL_PID"
        else
            while true; do
            echo -n "Kill ${GREEN}$KILL_PROGRAM $KILL_PORT${NC}($KILL_PID)? (y|n|q): "
            read -r readed </dev/tty
            if [[ "$readed" != "" ]]; then
                ans=$readed
            fi
            if [[ "$ans" == "y" ]]; then
                sudo kill -9 "$KILL_PID"
                break
            elif [[ "$ans" == "q" ]]; then
                return 0
            elif [[ "$ans" == "n" ]]; then
                break
            else
                echo "${RED}Try again${NC}"
                continue
            fi
            done
        fi
    done <<< "$KILL_PID_ALL"
)
}

shellproxy() {
  if [ $# -lt 1 ]; then
		echo "Usage: shellproxy <set | unset> [<host> <port>]"
		return 1
	fi
  # 设置使用代理
  if [[ "$1" == "set" ]]; then
    if [ $# -ne 3 ]; then
      echo "Usage: shellproxy <set | unset> <host> <port>"
      return 1
    fi
    export http_proxy="http://${2}:${3}"
    export https_proxy=$http_proxy 
    export all_proxy="socks5://${2}:${3}"
  elif [[ "$1" == "unset" ]]; then
    unset http_proxy
    unset https_proxy
    unset all_proxy
  else 
		echo "Usage: shellproxy <set | unset> <host> <port>"
		return 1
  fi
}
