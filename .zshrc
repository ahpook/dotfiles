# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# prezto startup first
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

## Bindkey section
# emacs-esque things i'm used to
bindkey "" history-incremental-search-backward
bindkey "_" insert-last-word
bindkey "" end-of-line
bindkey "" beginning-of-line
bindkey "" vi-backward-blank-word
bindkey "" vi-forward-blank-word

## alias section
alias changelog="echo \"* `date '+%a %b %d %Y'` Eric Sorenson <eric.sorenson@me.com> X\""
alias gwping="ping -q -c 10 $(netstat -rn | grep '^default.*UG' | awk '{print $2}')"
# sort a list of IPs numerically
alias ipsort='sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4'
alias oktapw="security find-generic-password -l device_trust '-w'"

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

# i guess we're doing golang now
GOPATH=$HOME/Sandbox/go
export GOPATH

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

pathmunge /opt/homebrew/bin
pathmunge /sbin
pathmunge /usr/sbin
pathmunge /usr/local/sbin
pathmunge /usr/local/bin
pathmunge $GOPATH/bin
pathmunge $HOME/.cargo/bin
unset pathmunge

# if the cool new rust stuff is found, use it
RBIN=$HOME/.cargo/bin
if [[ -d $RBIN ]]; then
  [[ -f $RBIN/bat ]] && for f in less more cat ; do 
    alias $f=bat; 
  done
  [[ -f $RBIN/dua ]] && alias du=dua
  [[ -f $RBIN/rg  ]] && alias grep=rg
  [[ -f $RBIN/exa ]] && alias ls=exa
  [[ -f $RBIN/fd  ]] && alias find=fd
fi

# no mo' rvm, use rbenv instead.
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# number of lines kept in history
export HISTSIZE=1000
# number of lines saved in the history after logout
export SAVEHIST=1000
# source credentials into environment, not tracked in git
[[ -f $HOME/.zsh/local_creds.szh ]] && source $HOME/.zsh/local_creds.zsh
# variables to set
TZ="America/Los_Angeles"

hasvim=`which vim 2>/dev/null`

if [[ $? == 0 ]]; then
        VISUAL=$hasvim
        SVN_EDITOR=$hasvim
else
        VISUAL=`which vi`
        SVN_EDITOR=$VISUAL
fi

export TZ PATH VISUAL SVN_EDITOR

# shared history is from Satan, and not in a good way
unsetopt share_history

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
