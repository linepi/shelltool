alias ..='cd ..'
alias ...='cd ../..'
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias trash='mv --force -t ~/.trash'
alias cg='cd `git rev-parse --show-toplevel`'
alias gh='history | grep'
alias rebash='. ~/.bashrc'

mcd () {
	mkdir -p $1
	cd $1	
}


