#!/bin/bash

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias ls='ls --color=auto'
alias ll='ls -la'
# -d means: list directories themselves, not their contents
alias l.='ls -d .* --color=auto'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias cg='cd `git rev-parse --show-toplevel`'
alias gh='history | grep'
alias rebash='. ~/.bashrc'
alias mansearch='apropos'
alias del='trash remove'

alias changemn='__RenameMachineName; rebash'
# machine name, which is shown before PS1
__RenameMachineName() {
(
	echo -n 'please input the machine name you want: '
	read -r machine_name
	COLOR_PF='\[\e['
	COLOR_SF='m\]'
	BLACK="${COLOR_PF}0;30${COLOR_SF}"
	RED="${COLOR_PF}0;31${COLOR_SF}"
	GREEN="${COLOR_PF}0;32${COLOR_SF}"
	YELLOW="${COLOR_PF}0;33${COLOR_SF}"
	BLUE="${COLOR_PF}0;34${COLOR_SF}"
	PURPLE="${COLOR_PF}0;35${COLOR_SF}"
	CYAN="${COLOR_PF}0;36${COLOR_SF}"
	WHITE="${COLOR_PF}0;37${COLOR_SF}"
	NC="${COLOR_PF}0${COLOR_SF}"
	if [[ "$SHELL" == "bash" ]]; then
		echo -n 'please input the color you want: '
		read -r machine_name_color
		if [[ "$machine_name_color" == "yellow" ]]; then  
			machine_name=${YELLOW}$machine_name${NC}
		elif [[ "$machine_name_color" == "blue" ]]; then  
			machine_name=${BLUE}$machine_name${NC}	
		elif [[ "$machine_name_color" == "red" ]]; then  
			machine_name=${RED}$machine_name${NC}	
		elif [[ "$machine_name_color" == "green" ]]; then  
			machine_name=${GREEN}$machine_name${NC}	
		elif [[ "$machine_name_color" == "purple" ]]; then  
			machine_name=${PURPLE}$machine_name${NC}	
		elif [[ "$machine_name_color" == "cyan" ]]; then  
			machine_name=${CYAN}$machine_name${NC}	
		elif [[ "$machine_name_color" == "white" ]]; then  
			machine_name=${CYAN}$machine_name${NC}	
		elif [[ "$machine_name_color" == "black" ]]; then  
			machine_name=${CYAN}$machine_name${NC}	
		else
			echo "Unknown color, use default"
		fi
		echo -n 'bold or underline or nothing? (b/u/n) '
		read -r machine_name_bold
		if [[ $machine_name_bold == b ]]; then
			machine_name=$(echo $machine_name | sed s/./1/6)
		elif [[ $machine_name_bold == u ]]; then
			machine_name=$(echo $machine_name | sed s/./4/6)
		fi
	fi
	echo "$machine_name" > $__SHELLTOOL_DIR/.machine_name
)
}
__GetMachineName() {
	if [[ -f $__SHELLTOOL_DIR/.machine_name ]]; then
	    	while IFS= read -r line; do
		    machine_name=$line
		done < $__SHELLTOOL_DIR/.machine_name
	else
		__RenameMachineName
	fi
}
__GetMachineName

rcfile=
shellname=
if [[ "$SHELL" =~ "bash" ]]; then
	export PS1="$machine_name $(if [ $? -eq 0 ]; then echo '\[\e[32m\]√\[\e[0m\]'; else echo '\[\e[31m\]$?\[\e[0m\]'; fi) \[\e[1;34m\]\w\[\e[0m\] $ "
	rcfile=~/.bashrc
    shellname='bash'
    export SHELL=bash
elif [[ "$SHELL" =~ "zsh" ]]; then
    export PS1="$machine_name %(?.%F{green}√.%F{red}%?) %F{blue}%~%f $ "
	rcfile=~/.zshrc
    shellname='zsh'
    export SHELL=zsh
else 
	echo "Unknown shell type"
fi

mcd () {
	mkdir -p "$1"
	cd "$1"
}

ncd() {
    del $1
    mcd $1
}

dockerinto() {
    docker start $1
    docker attach $1
}

recommit() {
    git add .
    git commit --amend --no-edit  
    git push -f
}

first() {
    echo $1
}

second() {
    echo $2
}

testfunc() {
    true && (echo 1; exit)
    echo 2
}

trash () {
(
    trash_dir=~/.trash
    record_file_name=trash_record_cache.wu

    trash-help() {
        echo "Usage:"
        echo "    init -- init trash"
        echo "    ls -- list files in trash"
        echo "    clear -- clear all files in trash"
        echo "    delete <file1>, <file2> ... -- delete file in trash"
        echo "    help -- show this help msg"
        echo "    remove <file1>, <file2> ... -- mv files to trash"
        echo "    restore <file1>, <file2> ... -- restore files to path before"
    }

    trash-record-exists() {
        garbage_name=$1
        if [[ $# -ne 1 ]] || ! [[ -f $trash_dir/$record_file_name ]]; then
            echo -e "${BOLD_RED}trash-record-exists ERROR${NC}"
            exit
        fi
        while IFS= read -r line
        do
            linerecord=$(first $line)
            [[ "$linerecord" == "'$garbage_name'" ]] && return 0
        done < $trash_dir/$record_file_name
        return 1 # means not exist
    }

    trash-record() {
        if [[ $# -ne 2 ]]; then
            echo -e "${BOLD_RED}trash-record param number is not 2${NC}"
            exit
        fi
        garbage_name=$1 # file in trash named garbage :D
        path_before=$2
        if ! [[ -f $trash_dir/$record_file_name ]]; then
            touch $trash_dir/$record_file_name
        fi
        if trash-record-exists $garbage_name; then
            echo -e "${BOLD_RED}trash-record: record exists${NC}"
            exit
        fi
        echo "'$garbage_name' '$path_before'" >> $trash_dir/$record_file_name
    }

    trash-derecord() {
        if [[ $# -ne 1 ]]; then
            echo -e "${BOLD_RED}trash-derecord ERROR${NC}"
            exit
        fi
        garbage_name=$1 

        # record must exist
        if ! trash-record-exists $garbage_name; then
            echo -e "${BOLD_RED}trash-derecord: record not exists${NC}"
            exit
        fi

        # deleting the record is same to
        # creating a new file which doesn't contain that record
        res=
        NEWLINE=$'\n'
        while IFS= read -r line; do
            if [[ $line == "" ]]; then
                continue
            fi
            linerecord=$(first $line)
            [[ "$linerecord" != "'$garbage_name'" ]] && res=$res$line$NEWLINE
        done < $trash_dir/$record_file_name
        echo -n "$res" > $trash_dir/$record_file_name
    }

    if [[ $# -eq 0 ]]; then 
        trash-help
        return
    fi

    if [[ $1 == "ls" ]]; then
        ls $trash_dir
        return
    elif [[ $1 == "clear" ]]; then
        echo -en "Really ${BOLD_RED}CLEAR${NC} trash? (y|n): "
        read -r readed < /dev/tty
        if [[ "$readed" == "y" ]]; then
            sudo rm -rf $trash_dir/*
        fi
        return
    elif [[ $1 == "help" ]]; then
        trash-help
        return
    elif [[ $1 == "init" ]]; then
        if [[ -d $trash_dir ]]; then
            echo "has been inited"
        else
            mkdir -p $trash_dir
        fi
        return
    elif [[ $1 == "restore" ]]; then
        for var in "${@: 2}"; do
            if ! [[ -f "$trash_dir/$var" ]] && ! [[ -d "$trash_dir/$var" ]]; then
                echo -e "trash: $var does not exists in trash" 
                continue
            fi

            res=
            NEWLINE=$'\n'
            while IFS= read -r line; do
                if [[ $line == "" ]]; then
                    continue
                fi
                linerecord=$(first $line)
                pathbefore=$(second $line)
                if [[ "$linerecord" == "'$var'" ]]; then
                    mv $trash_dir/$var ${pathbefore:1:-1}
                    # if file is not restored back, do not change record content
                    if [[ -f "$trash_dir/$var" ]] || [[ -d "$trash_dir/$var" ]]; then
                        res=$res$line$NEWLINE
                    fi
                else
                    res=$res$line$NEWLINE
                fi
            done < $trash_dir/$record_file_name
            echo -n "$res" > $trash_dir/$record_file_name
        done
        return
    elif [[ $1 == "delete" ]]; then
        for var in "${@: 2}"; do
            if ! [[ -f "$trash_dir/$var" ]] && ! [[ -d "$trash_dir/$var" ]]; then
                echo -e "trash: $var does not exists in trash" 
                continue
            fi
            rm -rf $trash_dir/$var
            trash-derecord $var
        done
        return
    elif [[ $1 == "remove" ]]; then
        if [[ $# -eq 1 ]]; then
            trash-help
            return
        fi
        for var in "${@: 2}"; do
            repeat_id=0
            _fpath_tmp=$trash_dir/${var}
            while true; do
                if ! [[ -f "$_fpath_tmp" ]] && ! [[ -d "$_fpath_tmp" ]]; then
                    break
                fi
                ((repeat_id++))
                _fpath_tmp=$trash_dir/${var}_Repeat$repeat_id
            done
            dstname=$var
            ((repeat_id != 0)) && dstname=${var}_Repeat$repeat_id
            mv $var $trash_dir/$dstname

            trash-record $dstname $(realpath $var)
        done
    else
        trash-help
    fi
)
}

RM () {
    echo -en "Permanently ${BOLD_RED}DELETE${NC}? (y|n): "
    read -r readed < /dev/tty
    if [[ "$readed" == "y" ]]; then
        rm -I --preserve-root -rf $@
    else
        return
    fi 
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
            echo -e "Killing ${GREEN}$KILL_PROGRAM $KILL_PORT${NC}($KILL_PID)"
            sudo kill -9 "$KILL_PID"
        else
            while true; do
            echo -en "Kill ${GREEN}$KILL_PROGRAM $KILL_PORT${NC}($KILL_PID)? (y|n|q): "
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
                echo -e "${RED}Try again${NC}"
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
