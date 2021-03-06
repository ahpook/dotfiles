# /etc/profile

# System wide environment and startup programs, for login setup
# Functions and aliases go in /etc/bashrc

function rmssh () {
    sed -ie "$1d" ~/.ssh/known_hosts
}

function hpre() {
            awk -v h="$1" '{printf("%24s | %s\n", h,$0);}'
}

# display cert info
function certinfo () {
    openssl x509 -in $1 -noout -text $*; 
}
   
# fix ssh; when your connecting screen/tmux session goes away, the child shells
# will lose access to your agent. run `fss` from a top-level shell, then `ss` from
# child shells and they'll be able to connect.
function fss() {
        [[ ! -z $SSH_AUTH_SOCK ]] && echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > ~/ssh.sh || echo "No SSH_AUTH_SOCK variable here"
}

function ss() {
        source ~/ssh.sh
        ssh-add -l
}


function pathmunge () {
        if ! echo $PATH | egrep "(^|:)$1($|:)" >/dev/null ; then
	   if [ "$2" = "after" ] ; then
              if [[ -d $1 ]]; then
                 PATH=$PATH:$1
              fi
	   else
              if [[ -d $1 ]]; then
                 PATH=$1:$PATH
              fi
	   fi
	fi
}

# Path manipulation
pathmunge /sbin
pathmunge /usr/sbin
pathmunge /opt/local/bin
pathmunge /opt/local/sbin
pathmunge /usr/local/sbin after
pathmunge /usr/local/bin after

alias changelog="echo \"* `date '+%a %b %d %Y'` Eric Sorenson <eric0@puppetlabs.com> X\""
 
# No core files by default
ulimit -S -c 0 > /dev/null 2>&1

CLICOLOR=1
HOSTNAME=`/bin/hostname`
HISTSIZE=10000

if [ -z "$INPUTRC" -a ! -f "$HOME/.inputrc" ]; then
    INPUTRC=/etc/inputrc
fi

PS1="[\u@\H \w]\\$ "

hasvim=`which vim 2>/dev/null`
if [[ $? == 0 ]]; then
        VISUAL=$hasvim
        SVN_EDITOR=$hasvim
else
        VISUAL=`which vi`
        SVN_EDITOR=$VISUAL
fi

SVN_SSH='ssh -q -l eric'

export PATH USER HOSTNAME HISTSIZE INPUTRC PS1 CLICOLOR VISUAL SVN_EDITOR SVN_SSH

unset i
unset pathmunge

TMOUT=0
export TMOUT
