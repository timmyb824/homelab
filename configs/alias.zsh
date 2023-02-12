# need this to use duf utility as oh-my-zsh already has duf alias
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  unalias duf
fi

alias zshconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"
alias cat="bat --paging=never -p"
alias btm="btm --color gruvbox"
alias {awsp,awsprofile}="source _awsp"
alias ls='lsd'
alias dockerps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.CreatedAt}}\t{{.Networks}}\t{{.State}}\t{{.RunningFor}}"'
alias dockerports='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.State}}\t{{.RunningFor}}"'
alias dcup='docker-compose up -d --force-recreate'
alias kk='kubectl'
alias kcx='kubectx'
alias kns='kubens'
alias ddown='docker-compose down'
alias dbuild='docker-compose up -d --force-recreate --build'
alias sshstart='eval `ssh-agent -s`'
alias sshadd='ssh-add ~/.ssh/id_master_key'
alias k3s='export KUBECONFIG=/Users/timothybryant/DevOps-Personal/gitea/k3s-cluster/config'
alias nano='/opt/homebrew/bin/nano' # added to use nano installed with brew
alias reload="source ~/.zshrc"
alias running_services='systemctl list-units  --type=service  --state=running'
