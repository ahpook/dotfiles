#!/bin/zsh

# target hosts to receive the sync

if [[ $# -gt 0 ]] ; then
    TARGETS=($@)
else
    TARGETS=(rdx.explosive.net shell.puppetlabs.com)
 
fi

echo -n "sync to localhost..."
rsync -rlp --stats --exclude=sync.zsh --exclude=.git/ . ~  && echo "OK"

for T in $TARGETS ; do
        if [[ -n $(echo $T | grep ":") ]] ; then
            HOSTSPEC=`echo $T | sed 's/:.*$//'`
            PATHSPEC=`echo $T | sed 's/^.*://'`
        else
            HOSTSPEC=$T
            PATHSPEC=""
        fi
	echo -n "sync to ${HOSTSPEC}:${PATHSPEC}"
        
        if ssh -6 -q -o"ConnectTimeout 5" $HOSTSPEC hostname > /dev/null 2>&1  
          ; then
		rsync -rlp --stats --exclude=sync.zsh --exclude=.git/ -e 'ssh -q' . ${HOSTSPEC}:${PATHSPEC}  && echo "OK"
	else
		echo "Failed"
	fi
done

