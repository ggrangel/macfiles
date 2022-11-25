# Change prompt
fpath=($ZDOTDIR/prompt $fpath)
source $HOME/.config/zsh/prompt/prompt.zsh

# disable Ctrl+s (freezes the terminal)
stty -ixon
# run bindkey for a list of zsh keybindings
bindkey -r "^D" # used to kill tmux pane and window. remove this zsh keybinding

setopt AUTOCD # enables .. to go back one dir
setopt AUTOPUSHD # push the curr dir visited to stack
setopt HIST_IGNORE_DUPS  # do not write duplicates to history
setopt HIST_FIND_NO_DUPS  # when searching, do not show duplicates
setopt INC_APPEND_HISTORY # allows sharing of history between concurrent shells
unsetopt BEEP # turn off all beeps
# unsetopt LIST_BEEP # turn off only autocomplete beeps

HISTFILE=$HOME/.cache/zsh_history
HISTSIZE=10000 # max events for internal history
SAVEHIST=10000 # max events in history file

# Basic auto/tab complete
autoload bashcompinit && bashcompinit
autoload -U compinit && compinit # loads a file containing shell commands
_comp_options+=(globdots)  # include hidden files in completions
source $ZDOTDIR/completion.zsh

complete -C '/usr/local/bin/aws_completer/' aws

[ -f "$ZDOTDIR/vi.zsh" ] && source "$ZDOTDIR/vi.zsh"

[ -f "$ZDOTDIR/aliasrc" ] && source "$ZDOTDIR/aliasrc"

[ -f "$ZDOTDIR/dev.zsh" ] && source "$ZDOTDIR/dev.zsh"

# export _ZO_DATA_DIR="$HOME/Insync/gustavorangel91@gmail.com/Google Drive/.local/share/zoxide/amzn"
export _ZO_ECHO=1 # z will print the matched directory before navigating to it.
eval "$(zoxide init zsh)"
# ^r to activate mcfly
eval "$(mcfly init zsh)"
export MCFLY_KEY_SCHEME=vim

export PATH="$PATH:$HOME/home/scripts:$HOME/.toolbox/bin"

# load zhs-syntax-highlighting; should be last.
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
