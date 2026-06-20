#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

eval "$(zoxide init bash)"

export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init bash)"

export PATH="$PATH:/opt/flutter/bin"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"

alias nvim-teste="NVIM_APPNAME=nvim-selan nvim"

export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
alias nk="NVIM_APPNAME=nvimkick nvim"
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
