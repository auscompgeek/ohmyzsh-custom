# Double-check the damn TERM.
# Appropriated from http://vim.wikia.com/wiki/256_colors_in_vim.

# Handle pesky terminals that call themselves xterm. (I'm looking at you, libvte.)
if [ "$TERM" = "xterm" ]; then
	case "$COLORTERM" in
		"")
			case "$XTERM_VERSION" in
				# My xterm reports itself as XTerm(297). Who knows.
				"XTerm(256)"|"XTerm(297)") TERM=xterm-256color ;;
				"XTerm(88)") TERM=xterm-88color ;;
				"XTerm") ;;
				"") echo "Warning: Terminal wrongly calling itself 'xterm'." >&2 ;;
				*) echo "Warning: Unrecognized XTERM_VERSION: $XTERM_VERSION" >&2 ;;
			esac
			;;

		# vte3 (GTK+ 3.0)
		gnome-terminal)
			TERM=gnome-256color
			;;

		# vte2 (GTK+ 2.0) -- I give up.
		xfce4-terminal)
			TERM=xterm-256color
			;;

		*) echo "Warning: Unrecognized COLORTERM: $COLORTERM" >&2 ;;
	esac
fi

# Make sure we've set a TERM that exists in our termcap/terminfo.
if [ -z "$terminfo[colors]" ]; then
	case "$TERM" in
		screen-*color-bce)
			echo "Unknown terminal $TERM. Falling back to 'screen-bce'." >&2
			TERM=screen-bce
			;;
		screen*) ;;  # Don't touch screen-*color here, let it fall back to 'screen' like it should.
		*-color)
			echo "Unknown terminal $TERM. Falling back to 'xterm-color'." >&2
			TERM=xterm-color
			;;
		*-16color)
			echo "Unknown terminal $TERM. Falling back to 'xterm-16color'." >&2
			TERM=xterm-16color
			;;
		*-88color)
			echo "Unknown terminal $TERM. Falling back to 'xterm-88color'." >&2
			TERM=xterm-88color
			;;
		*-256color|xterm-termite)
			echo "Unknown terminal $TERM. Falling back to 'xterm-256color'." >&2
			TERM=xterm-256color
			;;
	esac
	if [ -z "$terminfo[colors]" ]; then
		case "$TERM" in
			gnome*|xterm*|konsole*|aterm|[Ee]term|vte*)
				echo "Unknown terminal $TERM. Falling back to 'xterm'." >&2
				TERM=xterm
				;;
			rxvt*)
				echo "Unknown terminal $TERM. Falling back to 'rxvt'." >&2
				TERM=rxvt
				;;
			screen*)
				echo "Unknown terminal $TERM. Falling back to 'screen'." >&2
				TERM=screen
				;;
		esac
	fi
fi

export TERM  # just in case
