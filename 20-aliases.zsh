# gimme the usual l
alias l='ls -CF'

# ssh aliases
alias sshv="ssh -oProxyCommand='corkscrew 202.139.83.152 8070 %h %p' -oTCPKeepAlive=yes -p443 -C"
alias ipod='LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 mosh mobile@aucg-ipod.local'
alias ucpu0="mosh ucpu0 --server='LD_LIBRARY_PATH=~/.local/lib ~/.local/bin/mosh-server'"

alias -- +x='chmod +x'
