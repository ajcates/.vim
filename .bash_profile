export CLICOLOR=1
export PS1='\n-~-=-~-=-~-=-~-\n\u@\h/\w\n:'

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

# Alias for "." shows current directory
alias -- .='pwd'

#Grep in technocolor!
alias grep="grep --color=auto"

#Forcequit
alias forcequit="killall -HUP"


#quickly change the terms title
termtitle_func() {
	echo -n -e "\033]0;$1\007"
}
alias termtitle=termtitle_func

# Open a man page in Preview.app
pman() { man -t "${1}" | open -f -a /Applications/Preview.app; }

# Quit an OS X application from the command line
quit () {
    for app in $*; do
        osascript -e 'quit app "'$app'"'
    done
}
#Relaunch an application
relaunch () {
    for app in $*; do
        osascript -e 'quit app "'$app'"';
        sleep 2;
        open -a $app
    done
}

# "stop" a process
pause() {
	if [ $# -ne 1 ]; then
		echo 1>&2 Usage: stop process
	else
		PROCESS=$1
		echo "Stopping processes with the word ${tGreen}$1${tReset}"
		ps axw | grep -i $1 | awk -v PROC="$1" '{print $1}' | xargs kill -STOP
	fi
}

# "cont"inue a process
play() {
	if [ $# -ne 1 ]; then
		echo 1>&2 Usage: cont process
	else
    	PROCESS=$1
		echo "Continuing processes with the word ${tGreen}$1${tReset}"
		ps axw | grep -i $1 | awk -v PROC="$1" '{print $1}' | xargs kill -CONT
	fi
}


#Print the current Finder windows path
fp () {
	osascript -s e <<FPScript
	tell application "Finder"
		if (${1-1} <= (count Finder windows)) then
			get POSIX path of (target of window ${1-1} as alias)
		else
			get POSIX path of (desktop as alias)
		end if
	end tell
FPScript
};

#Quicklook
ql () {
	qlmanage -p $1 2>/dev/null
}



#editor
export EDITOR=mate

PATH=$PATH:~/.bin/:/usr/local/mysql/bin
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
