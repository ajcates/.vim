export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git)

if [ -s "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

alias g='git'
alias p='php'
alias n='node'
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -la'
alias -- .='pwd'
alias grep='grep --color=auto'

cdl() {
  cd "$@" && ls
}
alias cd='cdl'

export PATH="$HOME/.bin:$PATH"
export EDITOR="${EDITOR:-vim}"
