# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

###    PROMPT
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\] Make a wish! \[\033[01;34m\] \[\033[00m\] '
#          colors, working dir
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

PROMPT_DIRTRIM=1

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

######## code (compilation, running) #######

# python
alias p3='python3.6' #'python3'
alias p2='python2'   #'python2'
alias py='python'
alias jn='jupyter notebook'
alias ipy='ipython'

# java
alias jv='java'
alias jc='javac'

# gcc
alias c='gcc -g -Wall'

# make (valid iff you've created a "make" file)
alias m='make'
alias mc='make clean'
alias ma='make all'

#chmod
alias chmx='chmod +x'

############## getting around the terminal #############

# some more ls aliases
alias ll='ls -alF'
alias l='ls -ltrA'
alias lsize='ls -lS'

# stupidity protection : overwrite
alias rm='rm -i -v'
alias mv='mv -i -n -v'

# dirs
alias mkd='mkdir'
alias rmd='rmdir'

# find
alias f='find'

# grep
alias gr='grep -n'

# search filenames recursively
alias fg='find | grep'

# history: find old cmds
alias h='history'
alias hg='history | grep'
alias ht='history | tail'

# make screen darker
alias reds='redshift -O 1000 -b 0.5'
alias red='redshift'

#    opening files
# vim
alias v='vim'

# pdfs (evince)
alias ev='evince'

############## chaining cmds #############

# clear
alias clr='~/.clear.sh'  
alias cl='clear &&  ls -ltrA'
alias clpy='clear; ls -ltr *.py'
alias clpng='clear; ls -ltr *.png'
alias clsh='clear; ls -ltr *.sh'

# git
alias g='git'
alias gst='git status'
alias gad='git add'
alias gci='git commit -m'
alias gca='git commit -am'  # -a flag  commits all modified files in one step
alias gpus='git push'
alias gpul='git pull'

# gcloud
alias gcl='gcloud compute'

# specialized: login to CLAC
alias clac='ssh -X nxb2101@clac.cs.columbia.edu'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export EDITOR=vim

# virtualenv and virtualenvwrapper
# source /usr/local/bin/virtualenvwrapper.sh
# export WORKON_HOME=/home/n/.virtualenvs

# added by Anaconda3 installer
export PATH="/home/n/anaconda3/bin:$PATH"
export PATH="/usr/bin/:$PATH"

# added by me for proper Jupyter downloads?  I don't think it's necessary becuase this was already on my PATH"
# export PATH="/usr/bin:$PATH"

# added by Anaconda3 installer
export PATH="/home/n/anaconda3/bin:$PATH"

# Google Cloud
CLOUDSDK_PYTHON="/home/<username>/miniconda//envs/gcloud/bin/python2.7"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/n/google-cloud-sdk/path.bash.inc' ]; then source '/home/n/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/n/google-cloud-sdk/completion.bash.inc' ]; then source '/home/n/google-cloud-sdk/completion.bash.inc'; fi
