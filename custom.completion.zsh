#!/usr/bin/zsh


zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# Make Bash completion function somewhat compatible with zsh.
# Source: https://askql.wordpress.com/2011/01/11/zsh-writing-own-completion/
if [[ -n ${ZSH_VERSION-} ]]; then
    autoload -U +X compinit && compinit -u
    autoload -U +X bashcompinit && bashcompinit
fi

# This function checks whether we have a given program on the system.
# Extracted from: /usr/share/bash-completion/bash_completion
# Needed because it is used by the Bash completion functions that I create.
_have(){
    # Completions for system administrator commands are installed as well in
    # case completion is attempted via `sudo command ...'.
    PATH=$PATH:/usr/sbin:/sbin:/usr/local/sbin type $1 &>/dev/null
}

# Load completions from ~/.bash_completion.d directory
if [[ -d "$HOME/.bash_completion.d" ]]; then
    for bcfile in "$HOME/.bash_completion.d"/*; do
        source $bcfile
    done
fi

# This is to "preload" the _man function (used by the man command for auto completions).
# I use it with the "markman" command, which is a simple wrapper for opening man pages
# on a text editor.
# It would be great to use it...if it would freaking work!!!
# _completion_loader man
