# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="blinks"

plugins=(osx ruby battery bundler git-extras gem cp macports brew rake copydir copyfile)

source $ZSH/oh-my-zsh.sh

# Disable autocorrect for arguments, but enable it for commands.
unsetopt correct_all
setopt correct
# Change to a directory just by typing its name.
setopt autocd
# Use more powerful globbing
setopt extended_glob
# If a pattern doesn't match, pass it through unchanged
# This fixes issues with Rake task arguments in particular (`rake foo[bar]`)
unsetopt nomatch

# zmv is a pattern-based file renaming module.
autoload -U zmv

# Report the time taken for any command that takes longer than 10s to
# finish
REPORTTIME=10

alias chomp="perl -pe 'chomp if eof'"

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
	grep -v '^$' **/*.(js|php|rb) | grep -v '//' | wc -l
}

# Copy the last-run command to the clipboard
function clc() {
	fc -ln -1 | tr -d '\n' | pbcopy
}

# Copy the IP address of a hostname to the clipboard
function nscp() {
	nslookup $1 | sed -n 'x;$p' | cut -d' ' -f2 | tee >(pbcopy)
}

# I don't use C indent, so I'm happy to replace it
function indent() {
	sed 's/^/    /'
}

function cpsrc() {
	cat $1 | indent | pbcopy
}

# Compile Compass, making a guess about what directory to compile in.
function cc() {
	ls -d **/s(c|a)ss(:h) | xargs -n 1 compass compile --force
}

function mdcd() {
	mkdir $1 && cd $1
}

# cd into the most recently modified directory
function cdl() {
	cd $(print -rl -- *(/Dom[1]))
}

function fix_utf8() {
	iconv -f utf8 -t utf8 -c "$1" | sponge "$1"
}

function command_exists() {
	type $1 >/dev/null 2>&1
}

alias lsl="ls -ahl"
alias lsd="ls -ld *(-/DN)"
alias ls-today="ls *(m-1)"

[[ -f /usr/local/bin/ctags ]] && alias ctags="/usr/local/bin/ctags"

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

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward
bindkey -M viins 'jj' vi-cmd-mode

type src-hilite-lesspipe.sh >/dev/null 2>&1 && export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=' -RFX '

export EDITOR='vim'

[[ -s "$HOME/.z.sh" ]] && source "$HOME/.z.sh"

[[ -e "$HOME/private.sh" ]] && source "$HOME/private.sh"

[[ -e $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]] && source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

[[ -e /usr/libexec/java_home ]] && export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

DEFAULT_PATH=$PATH

# My scripts
PATH=~/bin:~/dotfiles/bin
# Homebrew
PATH+=:/opt/homebrew/bin
# Un-prefixed coreutils from Homebrew
PATH+=:/usr/local/opt/coreutils/libexec/gnubin
# Standard binaries
PATH+=:/usr/local/bin:/usr/bin:/bin
# System binaries
PATH+=:/usr/local/sbin:/usr/sbin:/sbin
# Rust: Cargo itself
PATH+=:~/.cargo/bin
# Rust: Cargo-installed Rust binaries
PATH+=:~/.multirust/toolchains/stable/cargo/bin
# MacPorts
PATH+=:/opt/local/bin:/opt/local/sbin
# XCode build tools
PATH+=:/Developer/usr/bin
# Pythonbrew
PATH+=:~/.pythonbrew/bin
# X11-related gubbins
PATH+=:/usr/X11/bin
# PEAR, the PHP package manager
PATH+=:~/pear/bin
# Composer
PATH+=:~/.composer/vendor/bin
# pip-installed binaries
PATH+=:/usr/local/share/python
# npm-installed binaries
PATH+=:/usr/local/share/npm/bin
# Big Fish shared scripts
PATH+=:~/bin/bigfish-scripts
# Whatever the path was originally set to
PATH+=:$DEFAULT_PATH

eval "$(rbenv init -)"

[[ -s "$HOME/.aws" ]] && . "$HOME/.aws"

[[ -s "$HOME/.secret" ]] && . "$HOME/.secret"

export PERL5LIB="/opt/local/lib/perl5/site_perl/5.12.3/"

export PARINIT="rTbgqR B=.,?_A_a Q=_s>|"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
