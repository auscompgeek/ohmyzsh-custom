#setopt completealiases

if [ "$TERM" = fbterm -o "$TERM" = linux ]; then
	eval "$(TERM=linux dircolors -b)"
#elif [ "$terminfo[colors]" -lt 256 ]; then
#	eval "$(dircolors -b)"
else
	[ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# from debian newuser.zshrc.recommended
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*:descriptions' format '%U%F{yellow}%d%f%u'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
