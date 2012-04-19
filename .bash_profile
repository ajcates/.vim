export CLICOLOR=1
#export PS1='\n-~-=-~-=-~-=-~-\n\u@\h/\w\n:'

#Set g as git
alias g='git'

#Set v as mvim
alias v='mvim'

#Set p as php
alias p='php'

#Set n as node
alias n='node'

#Set c as coffescript
alias n='coffescript'

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


tweet() {
  twitter -status=<<Tweet
  $1
Tweet
}



#shh short cuts
alias donkey='ssh ajcates@dev.eggheadventures.com'
alias websiteninjas='ssh ajcates@websiteninjas.com'

#alias term='open -a Terminal.app'
# open a new tab on Terminal with the current working dir
function newtab {
	osascript -s o <<AppleScript
    tell application "Terminal"
      activate
      tell application "System Events"
        keystroke "t" using {command down}
      end tell
      do script "$1" in selected tab of front window
    end tell
AppleScript
}

alias term='newtab'

//Opens up a project for us
function project {
  term "cd $1"
  open $1
  mvim $1
}

#projects and other book marks
export pAjcates='/Users/ajcates/Sites/projects/ajcates.local'
export pProjects='/Users/ajcates/Sites/projects'
export pCancer='/Users/ajcates/Sites/wsn/cancerKungFu'
export pSB='/Users/ajcates/Sites/projects/sweet-boilerplate'
export pWikiWaka='/Users/ajcates/Sites/projects/wiki-waka'
export pSweetOps='/Users/ajcates/Sites/egghead/sweet-ops'
export pHolsterData='/Users/ajcates/Sites/egghead/USAHolsters/holster-data'
export pSeaStinger='/Users/ajcates/Sites/egghead/seastinger.eggheadventures.com/'
export pCrad='/Users/ajcates/Sites/egghead/crad-db/'
export pFeedSync='/Users/ajcates/Sites/egghead/feed-sync/'
export pScripts='/Users/ajcates/Scripts/'
export pDownloads='/Users/ajcates/Downloads/'

##
# Your previous /Users/ajcates/.bash_profile file was backed up as /Users/ajcates/.bash_profile.macports-saved_2012-02-24_at_20:24:26
##

export PATH=~/.bin/:/usr/local/mysql/bin:/opt/local/bin:/opt/local/sbin:$PATH
#editor
export EDITOR=mvim
