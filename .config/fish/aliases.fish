# Custom neofetch
alias axfetch 'clear && neofetch --config ~/.config/neofetch/adrien.conf --kitty '~/.config/neofetch/ax.png' --size 270px --colors 1 7 7 1 7 7'
alias kittyfetch 'clear && neofetch --config ~/.config/neofetch/kitty.conf'
alias sansfetch 'clear && neofetch --config ~/.config/neofetch/adrien.conf --kitty '~/.config/neofetch/sans.png' --size 270px --colors 1 7 7 1 7 7'
alias adrienfetch 'clear && neofetch --config ~/.config/neofetch/adrien.conf --kitty '~/.config/neofetch/adrien.png' --size 270px --colors 1 7 7 1 7 7'
alias nguyenfetch 'clear && neofetch --config ~/.config/neofetch/nguyen.conf --kitty '~/.config/neofetch/nguyen.png' --size 250px --colors 1 7 7 1 7 7'

# Cava gradient support for Tmux
alias cavax 'TERM=st-256color cava'

# Yazi file
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end



