# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# DO load custom configuration for WarpTerminal
if [[ $TERM_PROGRAM = "WarpTerminal" ]]; then
  source "$HOME/.config/zsh/warp.zsh"
fi

# DO NOT load normal zsh configuration for WarpTerminal
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then

  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  # Path to your oh-my-zsh installation.
  export ZSH="/Users/timothybryant/.oh-my-zsh"

  # Set name of the theme to load --- if set to "random", it will
  # load a random theme each time oh-my-zsh is loaded, in which case,
  # to know which specific one was loaded, run: echo $RANDOM_THEME
  # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
  ZSH_THEME="powerlevel10k/powerlevel10k"

  # Uncomment one of the following lines to change the auto-update behavior
  # zstyle ':omz:update' mode disabled  # disable automatic updates
  zstyle ':omz:update' mode auto      # update automatically without asking
  # zstyle ':omz:update' mode reminder  # just remind me to update when it's time

  # Uncomment the following line to change how often to auto-update (in days).
  zstyle ':omz:update' frequency 13

  # Which plugins would you like to load?
  # Standard plugins can be found in $ZSH/plugins/
  # Custom plugins may be added to $ZSH_CUSTOM/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  # Add wisely, as too many plugins slow down shell startup.
  plugins=(git sublime vscode docker common-aliases copyfile)

  source $ZSH/oh-my-zsh.sh

  ###################USER CONFIGURATIONS##################

  #########SOURCES#########
  source "$HOME/.config/zsh/alias.zsh"
  source <(kubectl completion zsh)
  source /Users/timothybryant/.config/broot/launcher/bash/br
  source "$HOME/scripts/pyinfra-complete.zsh"
  source ~/.iterm2_shell_integration.zsh
  #########SOURCES#########

  #########EXPORTS#########
  export VAGRANT_DEFAULT_PROVIDER="parallels"
  export KUBE_EDITOR="nano"
  export EDITOR="nano"
  export PATH=$PATH:/usr/local/go/bin
  export GOPATH=$HOME/DevOps-Personal/go
  export PATH=$PATH:$HOME/DevOps-Personal/go/bin/
  export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"   #For compilers to find openssl@1.1
  export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"   #For compilers to find openssl@1.1
  export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig" #For pkg-config to find openssl@1.1
  export KUBECONFIG="/Users/timothybryant/.kube/config:/Users/timothybryant/.kube/config_k3s"
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
  #########EXPORTS#########

  #########EVALS#########
  eval "$(atuin init zsh)"
  eval "$(zoxide init zsh)"
  eval $(thefuck --alias)
  eval "$(register-python-argcomplete pipx)"
  eval "$(direnv hook zsh)"
  #########EVALS#########

  #########OTHER#########
  # Added by nvm install -TAB
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # Added for pyenv/pyenv-virtualenv -TAB
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
  fi

  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /opt/homebrew/bin/bit bit
  [ -f ~/.forgit/forgit.plugin.zsh ] && source ~/.forgit/forgit.plugin.zsh
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
  # Add my keys to the ssh agent; passwords are pulled from the keychain.
  # The --apple-load-keychain option is unique to MacOS.
  ssh-add --apple-load-keychain
  ulimit -n 1048576 1048576 # for sapling source control
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
  #########OTHER#########

  ###################USER CONFIGURATIONS##################

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

