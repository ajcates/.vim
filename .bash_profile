
#Set g as git
alias g='git'

#Set v as mvim
alias v='mvim'

#Set p as php
alias p='php'

#show directories whenver we change
cdl() {
	cd $1; ls
}
alias cd='cdl'

#list all
alias la='ls -a'

#Listerine
alias ll='ls -l'

#lal!
alias lal='ls -la'

alias term='open -a Terminal.app'
#projects
export pCancer='/Users/ajcates/Sites/wsn/cancerKungFu'
export pSB='/Users/ajcates/Sites/projects/sweet-boilerplate'
export pSweetOps='/Users/ajcates/Sites/egghead/sweet-ops'