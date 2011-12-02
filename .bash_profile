
PS1='\n-~-=-~-=-~-=-~-\n\u@\h/\w\n:'
#Set g as git
alias g='git'

#Set v as mvim
alias v='mvim'

#Set p as php
alias p='php'

#show directories whenver we change
cdl() {
	cd "$*"; ls
}
alias cd='cdl'

#list all
alias la='ls -a'

#Listerine
alias ll='ls -l'

#lal!
alias lal='ls -la'

#quickly change the terms title
termtitle_func() {
	echo -n -e "\033]0;$1\007"
}
alias termtitle=termtitle_func

#editor
export EDITOR=vi

PATH=$PATH:~/.bin/
export PATH

#shh short cuts
alias donkey='ssh ajcates@dev.eggheadventures.com'
alias websiteninjas='ssh ajcates@websiteninjas.com'

alias term='open -a Terminal.app'
#projects
export pCancer='/Users/ajcates/Sites/wsn/cancerKungFu'
export pSB='/Users/ajcates/Sites/projects/sweet-boilerplate'
export pWikiWaka='/Users/ajcates/Sites/projects/wiki-waka'
export pSweetOps='/Users/ajcates/Sites/egghead/sweet-ops'
export pHolsterData='/Users/ajcates/Sites/egghead/USAHolsters/holster-data'
export pSeaStinger='/Users/ajcates/Sites/egghead/seastinger.eggheadventures.com/'
export pCrad='/Users/ajcates/Sites/egghead/crad-db/'
export pFeedSync='/Users/ajcates/Sites/egghead/feed-sync/'
