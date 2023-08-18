# Change prompt
fpath=($ZDOTDIR/prompt $fpath)
source $HOME/.config/zsh/prompt/prompt.zsh

export PASSWORD_STORE_CLIP_TIME=300

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

# info on how to install brazil autocomplete:
# https://w.amazon.com/bin/view/CSWWCP/OR/Onboarding/brazil_autocompletion_mac/
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Basic auto/tab complete
fpath=($ZDOTDIR/completion $fpath)
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit -i # loads a file containing shell commands
_comp_options+=(globdots)  # include hidden files in completions
source $ZDOTDIR/completion.zsh

complete -C '/usr/local/bin/aws_completer/' aws

[ -f "$ZDOTDIR/vi.zsh" ] && source "$ZDOTDIR/vi.zsh"

[ -f "$ZDOTDIR/aliasrc" ] && source "$ZDOTDIR/aliasrc"

[ -f "$ZDOTDIR/dev.zsh" ] && source "$ZDOTDIR/dev.zsh"

export _ZO_ECHO=1 # z will print the matched directory before navigating to it.
eval "$(zoxide init zsh)"
# ^r to activate mcfly
eval "$(mcfly init zsh)"
export MCFLY_KEY_SCHEME=vim

export PATH="$PATH:$HOME/home/scripts:$HOME/.toolbox/bin:/Applications/Fortify/Fortify_SCA_and_Apps_21.2.2/bin:$HOME/.local/bin"

# load zhs-syntax-highlighting; should be last.
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
