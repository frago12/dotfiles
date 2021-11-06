alias reload='source ~/.zshrc'

alias diff=colordiff
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

alias ls='ls -G'
alias ll='ls -lad'
alias npx='pnpx'
alias ta='tmux a -t'
alias ..='cd ..'
alias home='cd ~'

alias brew-prefix-user='sudo chown -R $(whoami) $(brew --prefix)/*'
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor; brew bundle'

alias git-tree='tree = log --graph --decorate --pretty=oneline --abbrev-commit'

alias forkapp="open -a fork"

alias npm-global="npm ls -g --depth=0"