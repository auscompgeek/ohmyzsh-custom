if [ "$TERM" = fbterm -o "$TERM" = linux ]; then
	eval "$(TERM=linux dircolors -b)"
#elif [ "$terminfo[colors]" -lt 256 ]; then
#	eval "$(dircolors -b)"
else
	[ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
