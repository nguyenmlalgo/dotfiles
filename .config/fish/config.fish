if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting
thefuck --alias | source
starship init fish | source
source ~/.config/fish/aliases.fish
source ~/.config/fish/ffmpeg.fish
source ~/.config/fish/env.fish
source ~/.config/fish/autostart.fish
zoxide init fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/nguyen/miniconda3/bin/conda
    eval /home/nguyen/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/nguyen/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/nguyen/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/nguyen/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/nguyen/.lmstudio/bin
# End of LM Studio CLI section


fish_add_path /home/nguyen/.spicetify
