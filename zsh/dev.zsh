# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"  # enable auto-activation of virtualenvs

# Ruby Version Manager: enables `rails new <project_dir>`
# source "$HOME/.rvm/scripts/rvm"

# Node version manager
# source /usr/share/nvm/init-nvm.sh

# export PATH="$PATH:$CARGO_HOME/bin" # rust
# export PATH="$PATH:$HOME/.rvm/bin" # ruby
# export PATH="$PATH:$PYENV_ROOT/bin" # python

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-17.0.4.jdk/Contents/Home/bin/java"

export NVM_DIR="$HOME/.config/nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
