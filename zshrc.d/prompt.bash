# -------
# Load version control information
autoload -U colors && colors
autoload -U vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
zstyle ':vcs_info:git:*' formats '(%b)'
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
# -------

# Config for prompt.
NEWLINE=$'\n'
PROMPT_TEMPLATE='${NEWLINE}%B%{$fg[magenta]%}[%{$fg[blue]%}%~%{$fg[magenta]%}]%{$fg[yellow]%}${vcs_info_msg_0_}%{$reset_color%}$%b${NEWLINE}'
PROMPT="${PROMPT_TEMPLATE}"

function update_prompt() {
    PROMPT="${PROMPT_TEMPLATE}"
}