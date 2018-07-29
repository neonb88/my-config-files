# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# TODO:  make bash prompt cycle through things I should remember (ie. python syntax, Lisp syntax, whatever else I'm working on at the moment. It could also link to a UNIX manpage)

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

#
PROMPT_DIRTRIM=5

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
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\] Make a wish! \[\033[01;34m\] \[\033[00m\] '
#          colors, working dir
    PS1=' ' # just a slight indent
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1=' ' # just a slight indent
fi
# if we need ANY information at all, we can get it.  This is better, even through it requires more effort, because there is less clutter on the screen.  Always always minimalism and cleanliness

unset color_prompt force_color_prompt

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

# lisp
alias arc='/home/n/arc/arc-nu/arc'
#alias arc='/home/n/racket/bin/racket -f /home/n/mz/tmp/arc3.1/as.scm'
#alias arc='/home/n/arc/anarki/arc.sh -n'
alias ra='/home/n/racket/bin/racket -il xrepl'
alias rac='/home/n/racket/bin/racket -il xrepl'
alias racket='/home/n/racket/bin/racket -il xrepl'

# python
alias python='python2'
alias py='python2'
alias p='python2'
alias p3='python3.5' #'python3'
alias p36='python3.6'
alias p2='python2'   #'python2'
alias jn='jupyter notebook'
alias ipy='ipython'

# virtual envs, conda
alias ca='source activate cat'

# node
alias n='node'

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

#time
alias t='time'
############################################################################################################################################  
############################################        getting around the terminal         ####################################################
############################################################################################################################################  

# some more ls aliases
alias l='ls -ltrAh'
alias lt='ls -ltrAh | tail'

# dirs
alias ld='ls -ltrAdh */'

alias ltail='ls -ltrAh | tail'
alias lhead='ls -ltrAh | head'
alias lsize='ls -lSh'

# ls [type of file]
alias lpy='ls -ltrAh *.py'
alias lnpy='ls -ltrAh *.npy'
alias lpng='ls -ltrAh *.png'
alias ltxt='ls -ltrAh *.txt'
alias ljpg='ls -ltrAh *.jpg'
alias lswp='ls -ltrAh .*.swp'
alias lsh='ls -ltrAh *.sh'
alias lpdf='ls -ltrAh *.pdf'
alias lmp4='ls -ltrAh *.mp4'
alias lcpp='ls -ltrAh *.cpp'
alias lc='ls -ltrAh *.c'
alias ljava='ls -ltrAh *.java'
alias lscala='ls -ltrAh *.scala'
alias lsc='ls -ltrAh *.sc'
alias lo='ls -ltrAh *.o'
alias lrb='ls -ltrAh *.rb'
alias lpl='ls -ltrAh *.pl'
alias lPL='ls -ltrAh *.PL'
alias lsav='ls -ltrAh *.sav'
alias ljar='ls -ltrAh *.jar'
alias lrtf='ls -ltrAh *.rtf'
alias lbmp='ls -ltrAh *.bmp'
alias ltif='ls -ltrAh *.tif'
alias lsvg='ls -ltrAh *.svg'
alias lhtm='ls -ltrAh *.htm'
alias lxhtml='ls -ltrAh *.xhtml'
alias lphp='ls -ltrAh *.php'
alias lWAV='ls -ltrAh *.WAV'
alias ltgz='ls -ltrAh *.tar.gz'
alias ltar='ls -ltrAh *.tar'
alias lbin='ls -ltrAh *.bin'
alias liso='ls -ltrAh *.iso'
alias lcsv='ls -ltrAh *.csv'
alias lxml='ls -ltrAh *.xml'
alias ljson='ls -ltrAh *.json'
alias ljs='ls -ltrAh *.js'
alias lhtml='ls -ltrAh *.html'
alias lcss='ls -ltrAh *.css'
alias lgif='ls -ltrAh *.gif'
alias ljpeg='ls -ltrAh *.jpeg'
alias lwebm='ls -ltrAh *.webm'
alias lodt='ls -ltrAh *.odt'
alias lwav='ls -ltrAh *.wav'
alias lmp3='ls -ltrAh *.mp3'
alias logv='ls -ltrAh *.ogv'
alias lzip='ls -ltrAh *.zip'
alias ldeb='ls -ltrAh *.deb'
alias lpart='ls -ltrAh *.part'
alias lppt='ls -ltrAh *.ppt'
alias lpptx='ls -ltrAh *.pptx'
alias lodp='ls -ltrAh *.odp'
alias lclass='ls -ltrAh *.class'
alias llisp='ls -ltrAh *.lisp'
alias llsp='ls -ltrAh *.lsp'
alias lel='ls -ltrAh *.el'
alias lbash='ls -ltrAh .bashrc'
alias lvim='ls -ltrAh .vimrc'
alias lswift='ls -ltrAh *.swift'
alias lvb='ls -ltrAh *.vb'
alias lh='ls -ltrAh *.h'
alias lcs='ls -ltrAh *.cs'
alias lods='ls -ltrAh *.ods'
alias lxls='ls -ltrAh *.xls'
alias lxlsx='ls -ltrAh *.xlsx'
alias lxlr='ls -ltrAh *.xlr'
alias lavi='ls -ltrAh *.avi'
alias lmov='ls -ltrAh *.mov'
alias ltex='ls -ltrAh *.tex'
alias l7z='ls -ltrAh *.7z'
alias lpyc='ls -ltrAh *.pyc'
alias lmd='ls -ltrAh *.md'
alias lexe='ls -ltrAh *.exe'
alias lso='ls -ltrAh *.so'
alias ltargz='ls -ltrAh *.tar.gz'
alias lR='ls -ltrAh *.R'
alias lmm='ls -ltrAh *.mm'
alias lm='ls -ltrAh *.m'
alias lM='ls -ltrAh *.M'
alias lmat='ls -ltrAh *.mat'
alias lts='ls -ltrAh *.ts'
alias ltsx='ls -ltrAh *.tsx'
alias lVBA='ls -ltrAh *.VBA'
alias lkts='ls -ltrAh *.kts'
alias lkt='ls -ltrAh *.kt'
alias lgo='ls -ltrAh *.go'
alias lrs='ls -ltrAh *.rs'
alias lrlib='ls -ltrAh *.rlib'
alias lhs='ls -ltrAh *.hs'
alias llhs='ls -ltrAh *.lhs'
alias lpp='ls -ltrAh *.pp'
alias lpas='ls -ltrAh *.pas'
alias linc='ls -ltrAh *.inc'
alias lclj='ls -ltrAh *.clj'
alias lcljs='ls -ltrAh *.cljs'
alias lcljc='ls -ltrAh *.cljc'
alias ledn='ls -ltrAh *.edn'
alias lcl='ls -ltrAh *.cl'
alias lfasl='ls -ltrAh *.fasl'
alias lscm='ls -ltrAh *.scm'
alias lss='ls -ltrAh *.ss'
alias lhy='ls -ltrAh *.hy'
alias llfe='ls -ltrAh *.lfe'
alias lhrl='ls -ltrAh *.hrl'
alias lerl='ls -ltrAh *.erl'
alias lex='ls -ltrAh *.ex'
alias lexs='ls -ltrAh *.exs'
alias ljl='ls -ltrAh *.jl'
alias lrkt='ls -ltrAh *.rkt'
alias lrktl='ls -ltrAh *.rktl'
alias lrktd='ls -ltrAh *.rktd'
alias lscrbl='ls -ltrAh *.scrbl'
alias lplt='ls -ltrAh *.plt'
alias lcbl='ls -ltrAh *.cbl'
alias lcob='ls -ltrAh *.cob'
alias lcpy='ls -ltrAh *.cpy'
alias lpkl='ls -ltrAh *.pkl'

# stupidity protection against overwrites
alias rm='rm -iv'
alias mv='mv -iv'
alias cp='cp -iv'
    # -inv always does "no clobber"

# dirs
alias mkd='mkdir'
alias rmd='rm -ri'

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

# diff
alias d='diff'

# date
alias d8='date'

############################################################################################################################################  
###############   not just text and coding : other utils (Web, evince)                      ################################################  
############################################################################################################################################  
# make screen darker
alias reds='redshift -O 1000'
alias red='redshift'

#    opening files
# vim
alias v='vim'
alias gv='gvim'

# pdfs (evince)
alias ev='evince'

# more user-friendly, rememberable commands
alias disk='df'
alias user='whoami'
alias files='nautilus --browser ./'

# installs
alias inst='sudo apt-get install'
alias aptinst='sudo apt install'
alias upd8='sudo apt-get update'
alias upgr='sudo apt-get upgrade'

# web
alias w='w3m google.com'
#alias w3m='w3m google.com'

############################################################################################################################################  
############## chaining cmds #############
############################################################################################################################################  

# clear
alias clr='~/.clear.sh'  
alias cl='clear &&  ls -ltrA'
alias clpy='clear; ls -ltr *.py'
alias clpng='clear; ls -ltr *.png'
alias clsh='clear; ls -ltr *.sh'

# git
alias g='git'
alias galias='git config --get-regexp alias'  # technically incomplete, see https://stackoverflow.com/questions/7066325/list-git-aliases
alias gst='git status'
alias gsh='git status | head -n20'
alias gad='git add'
alias gci='git commit -m'
alias gca='git commit -am'  # -a flag  commits all modified files in one step
alias gpus='git push'
alias gpul='git pull'

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



export HISTTIMEFORMAT="%d/%m/%y %T "

# OpenCV
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"




export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# blender
export PATH="/opt/blender/:$PATH"
