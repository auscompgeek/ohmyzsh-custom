# Double-check the damn TERM.
# Appropriated from http://vim.wikia.com/wiki/256_colors_in_vim.

# Handle pesky terminals that call themselves xterm. (I'm looking at you, vte2.)
if [ "$TERM" = "xterm" ]; then
	if [ -n "$VTE_VERSION" ]; then
		TERM=vte-256color
	elif [ -n "$COLORTERM" ]; then
		# eh.
		TERM=xterm-256color
	else
		case "$XTERM_VERSION" in
			# Screw it. I don't give a damn any more.
			XTerm\(???*\)) TERM=xterm-256color ;;
			"XTerm(88)") TERM=xterm-88color ;;
			XTerm) ;;
			"") echo "Warning: Terminal wrongly calling itself xterm." >&2 ;;
			*) echo "Warning: Unrecognized XTERM_VERSION: $XTERM_VERSION" >&2 ;;
		esac
	fi
fi

__set_term() {
	echo "Unusable TERM $TERM; falling back to $1." >&2
	TERM="$1"
}

# Make sure we have a TERM that has colours.
# If it doesn't have colours, it probably isn't in our termcap/terminfo.
if [ -z "$terminfo[colors]" ]; then
	case "$TERM" in
		screen-*color-bce) __set_term screen-bce ;;
		tmux-256color) __set_term screen-256color ;;
		screen*|tmux*) ;;  # Don't touch screen/tmux-*color here, let it fall back to screen.

		rxvt-unicode*) __set_term "${TERM/-unicode/}" ;;

		# Only xterm-alikes should get here.
		*-color) __set_term xterm-color ;;
		*-16color) __set_term xterm-16color ;;
		*-88color) __set_term xterm-88color ;;
		*-256color|xterm-termite) __set_term xterm-256color ;;
	esac
	if [ -z "$terminfo[colors]" ]; then
		case "$TERM" in
			gnome*|xterm*|konsole*|aterm|[Ee]term|vte*) __set_term xterm ;;
			rxvt*) __set_term rxvt ;;
			screen*|tmux*) __set_term screen ;;
		esac
	fi
fi

unfunction __set_term
export TERM  # just in case
