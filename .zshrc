
# prezto startup first
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

## Bindkey section
# emacs-esque things i'm used to
bindkey "" history-incremental-search-backward
bindkey "_" insert-last-word
bindkey "" end-of-line
bindkey "" beginning-of-line
bindkey "" vi-backward-blank-word
bindkey "" vi-forward-blank-word

## alias section
alias changelog="echo \"* `date '+%a %b %d %Y'` Eric Sorenson <eric.sorenson@puppetlabs.com> X\""
alias gwping="ping -q -c 10 $(netstat -rn | grep '^default.*UG' | awk '{print $2}')"
# sort a list of IPs numerically
alias ipsort='sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4'

## function section, for things longer than aliases
function btmm () {
     echo -n "128266953.members.btmm.icloud.com"
}

function sq()
{
        ssh     -oLogLevel=ERROR \
                -oConnectTimeout=8 \
                -oPasswordAuthentication=no \
                -oNumberOfPasswordPrompts=0 \
                -oServerAliveInterval=1 \
                -oServerAliveCountMax=8 \
                -oBatchMode=yes \
                -oUserKnownHostsFile=/dev/null \
                -oGlobalKnownHostsFile=/dev/null \
                -oCheckHostIP=no \
                -oStrictHostKeyChecking=no \
                "$@"
}
    

# these two let you exchange contents from tmux's copy-paste buffer into
# the mac os paste buffer - relies on the 'load-buffer' and 'save-buffer'
# tmux commands being bound
function pbget () {
        sq $1 cat /tmp/tmux-exchange-eric | pbcopy
}
function pbput () {
        sq $1 pbpaste | ssh $1 cat > /tmp/tmux-exchange-eric
}

# display cert info
function certinfo () {
    openssl x509 -in $1 -noout -text $*; 
}

## shell vars section

# repetition-avoiding PATH manipulation from RH /etc/profile
function pathmunge () {
	if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
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
pathmunge /sbin
pathmunge /usr/sbin
pathmunge /usr/local/sbin
pathmunge /usr/local/bin
pathmunge /opt/local/bin
pathmunge /opt/local/sbin
unset pathmunge


# number of lines kept in history
export HISTSIZE=1000
# number of lines saved in the history after logout
export SAVEHIST=1000
# location of history
export HISTFILE=$HOME/.zhistory
# source credentials into environment, not tracked in git
source $HOME/.zsh/local_creds.zsh
# variables to set
TZ="America/Los_Angeles"

# no mo' rvm, use rbenv instead.
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

hasvim=`which vim 2>/dev/null`
if [[ $? == 0 ]]; then
        VISUAL=$hasvim
        SVN_EDITOR=$hasvim
else
        VISUAL=`which vi`
        SVN_EDITOR=$VISUAL
fi

export TZ PATH VISUAL SVN_EDITOR
