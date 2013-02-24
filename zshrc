# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="blinks"

plugins=(osx ruby battery github sublime)

source $ZSH/oh-my-zsh.sh

# Disable autocorrect for arguments, but enable it for commands.
unsetopt correct_all
setopt correct
# Change to a directory just by typing its name.
setopt autocd
# Use more powerful globbing
setopt extended_glob

# zmv is a pattern-based file renaming module.
autoload -U zmv

function webdev_mysql() {
  echo "Killing existing connection (sudo)..."
  sudo lsof -Pnl +M -i @127.0.0.1:3306 | awk '/[0-9]/ {print $2}' | xargs sudo kill
  echo "Opening new connection (ssh)..."
  ssh -f -L 3306:localhost:3306 webdev.bigfish.co.uk -N
}

function scratch() {
	if [ -f ~/Dropbox/Elements/Scratchpad.txt ]; then
		vim ~/Dropbox/Elements/Scratchpad.txt
	fi
}

function spaces_to_tabs() {
	sed -i '' -E "s/    /       /g" **/*(.)
}

function strip_trailing_whitespace() {
	sed -i '' -E "s/[[:space:]]*$//" **/*(.)
}

# Count the significant lines of code in the current directory.
function sloc() {
	grep -v '^$' **.(js|php) | grep -v '//' | wc -l
}

# Compile Compass, making a guess about what directory to compile in.
function compile_compass() {
	ls -d1 **/.sass-cache/../ | xargs -L1 compass compile --force -s compressed
}

alias lsl="ls -ahl"

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    bg
    zle redisplay
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward
bindkey -M viins 'jj' vi-cmd-mode

export LESSOPEN="| /usr/local/Cellar/source-highlight/3.1.5/bin/src-hilite-lesspipe.sh %s"
export LESS=' -RFX '

[[ -s "$HOME/.z.sh" ]] && source "$HOME/.z.sh"

export PATH=$PATH:/Developer/usr/bin:~/.pythonbrew/bin:/opt/local/bin:/opt/local/sbin:/Users/rob/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Developer/usr/bin:/Users/rob/pear/bin:/usr/local/sbin:$HOME/.rvm.bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export PERL5LIB="/opt/local/lib/perl5/site_perl/5.12.3/"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
