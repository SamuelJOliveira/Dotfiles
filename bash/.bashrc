# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc
export JAVA_HOME=/home/Sdk/jdk-25.0.2
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/Sdk/flutter/bin:$PATH"
export CHROME_EXECUTABLE=/usr/bin/chromium

# Definindo o diretório base
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_AVD_HOME=$HOME/.config/.android/avd
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1

# Adicionando ao PATH (Sintaxe para BASH)
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

alias emu='~/Android/Sdk/emulator/emulator -avd Medium_Phone_API_36.1 -gpu host -feature -Vulkan'
alias y="yazi"
alias t="tmux"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
