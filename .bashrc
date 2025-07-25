
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# TODO: generalize this .bashrc such that even when we're on the AWS ec2 instance we can still call /home/`whoami`/... as part of the path

# TODO:  make bash prompt cycle through things I should remember (ie. python syntax, Lisp syntax, whatever else I'm working on at the moment. It could also link to a UNIX manpage)
  # TODO: make sure all the usual emacs shortcuts (ctrl+key) still work when we have vim mode active

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=10000
#HISTFILESIZE=20000

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

#
PROMPT_DIRTRIM=5







# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/n/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/n/anaconda3/etc/profile.d/conda.sh" ]; then
# . "/home/n/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/n/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

conda init
conda init bash
conda init zsh









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
#PS1='===========================================\n    '
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]===========================================\n   \[\033[01;34m\]\[\033[00m\]'
##          colors, working dir
    #PS1=' ' # just a slight indent
#else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    #PS1=' ' # just a slight indent
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
alias arc='time /home/n/arc/arc-nu/arc'
#alias arc='/home/n/racket/bin/racket -f /home/n/mz/tmp/arc3.1/as.scm'
#alias arc='/home/n/arc/anarki/arc.sh -n'
alias ra='time /home/n/racket/bin/racket -il xrepl'
alias rac='time /home/n/racket/bin/racket -il xrepl'
alias racket='time /home/n/racket/bin/racket -il xrepl'

# python
alias p='date && time python'
alias py='date && time python3'
alias p3='date && time python3'
alias p38='date && time python3.8'
alias p37='date && time python3.7'
alias p36='date && time python3.6'
alias p35='date && time python3.5'
alias p2='date && time python2'
alias python2='python2'
alias python3='python3'
alias jn='jupyter notebook'
alias ipy='ipython'

# virtual envs, conda
# TODO: prune after conda reinstall.  
alias mag='conda activate magicke___March_5_2021_'

alias ca='conda activate cat12' # 'source activate cat'   # 12,11, 4 are the working ones right now (Mon Mar  4 13:28:47 EST 2019)
alias ca11='conda activate cat11'
alias ca12='conda activate cat12'
alias ju='conda activate jupyter'
alias c2='conda activate cat2' #'source activate cat2'
alias c3='conda activate cat_opencv3' #'source activate cat_opencv3'
alias my='conda activate my_cat' #'source activate my_cat'
alias cinst='conda install'
alias pinst='pip install'
alias de='conda deactivate' #'source deactivate'
alias ac='conda activate'   #'source activate'

# java
alias jv='time java'
alias jc='time javac'

#chmod
alias chmx='chmod +x'

#time
alias t='time'
# TODO:   time for conda operations (downloads, installs, copying environments, all take lotsa time)
############################################################################################################################################  
############################################        getting around the terminal         ####################################################
############################################################################################################################################  

alias grnot='grep -v'   # grep negative    (grep exclude [queryName])
alias excludelonglines='grep "^.\{0,300\}$"'
#alias cut='cut -n9-19'   Here's how to cut (ie. `cat fname.txt | cut -n9-19` cuts out chars 9 to 19)

alias up='c ..'
alias down='c `ls -dt */ |head -n1`' # NOTE: doesn't go down .git dirs, just like we'd like.  Also doesn't go down other "hidden" dirs like `~/.vim`, however.

alias spaces='echo "Bash version: ${BASH_VERSION}...";for i in {1..49..1}; do echo ""; done' # TODO: how to change "49" to any N we want?   also NOTE the second "1" in the "for i in {1..49..1}" is the step size (ie. for i in range(1,9,2) in python. 
alias fewer_spaces='for i in {1..29}; do echo ""; done'
alias fewer_fewer_spaces='for i in {1..15}; do echo ""; done'
alias 20='for i in {1..20}; do echo ""; done'
alias 10='for i in {1..10}; do echo ""; done'
alias 9='for i in {1..9}; do echo ""; done'
alias 5='for i in {1..5}; do echo ""; done'
alias 2='for i in {1..2}; do echo ""; done'

#    for i in {1..49}; do echo ""; done
# some more ls aliases
#alias l='date && pwd && ls -ltrAh && 2'  # <==   doesn't work for `l filename`
alias l='2 && date && pwd && ls -ltrAh' #     old:   alias l='date && pwd && ls -ltrAh   && 2'     <==   doesn't work for `l filename`
alias lt='l | tail'
alias lold='ls -ltAh | tail'

# dirs
alias ldir='ls -ltrAdh */'  # ld is a different command (a "REAL" UNIX command) that I was overwriting
alias ldi='ls -ltrAdh */ .*/'  # ld is a different command that I was overwriting

alias lwc='l|wc'
alias ltail='ls -ltrAh | tail'
alias lhead='ls -ltrAh | head'
alias lsize='ls -lSrh'

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
alias lobj='ls -ltrAh *.obj'
alias lipynb='l *ipynb'
alias ljn='l *ipynb'
alias lblend='l *blend'
alias lnpz='l *npz .*npz'
alias lsb3='l *sb3'

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
alias fgr='find | grep'

# history: find old cmds
alias h='history && printf "======================\n" && date'
alias hgr='date && printf "======================\n" && history | grep'
alias ht='date && printf "======================\n" && history | tail'
#alias hp='' # plain; no times, numbers, etc.  TODO

# diff
alias d='diff'

# date
alias d8='date'
alias da='date'

############################################################################################################################################  
###############   not just text and coding : other utils (Web, evince)                      ################################################  
############################################################################################################################################  
# make screen darker
alias reds='redshift -O 1000'
alias red='redshift'
alias redx='redshift -x'

#    opening files
# vim
alias v='date && printf "===============\n" && vim'
#alias v='nvim' #nvim crashed.  Idek why I'd use it over tmux, anyway.
alias sv='sudo vim'

# vim mode (Luke Smith tutorial: https://www.youtube.com/watch?v=GqoJQft5R2E):
set -o vi
bind '"jk":vi-movement-mode'
bind '"jK":vi-movement-mode'
bind '"Jk":vi-movement-mode'
bind '"JK":vi-movement-mode'
bind '"kj":vi-movement-mode'
bind '"kJ":vi-movement-mode'
bind '"Kj":vi-movement-mode'
#   bind '"KJ":vi-movement-mode'

bind '"jj":vi-movement-mode'
bind '"jJ":vi-movement-mode'
bind '"Jj":vi-movement-mode'
bind '"JJ":vi-movement-mode'
bind '"kk":vi-movement-mode'
bind '"kK":vi-movement-mode'
bind '"Kk":vi-movement-mode'
bind '"KK":vi-movement-mode'

bind -x '"\C-l": clear;'      # clear screen with ctrl+l

#emacs-like bindings that come with bash
bind "\C-a":beginning-of-line
bind "\C-k":kill-line
bind '"\ed":kill-word'  # \e means alt
bind "\C-f":forward-char
bind '"\ef":forward-word'
bind "\C-b":backward-char
bind '"\eb":backward-word'
bind "\C-n":menu-complete
bind "\C-p":menu-complete-backward
# bind "\A-f":forward-word
# bind "\C-d":delete-char
# bind "\C-t"         # swap-char?  idk what it's called

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
alias w3='w3m google.com' # 'w' is a command in unix.  Who knew?
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
alias gad='git add -f' # goes thru .gitignore
alias gci='git commit -m'
alias gca='git commit -am'  # -a flag  commits all modified files in one step
alias gpus='git push'
alias gpul='git pull'
# TODO: make a shell script that somehow smoothly combines gad, gci, and gpus.

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




#export HISTTIMEFORMAT="%d/%m/%y %T "


#===================================================================================================
#========================================= "Cat" stuff: ============================================
#===================================================================================================
# OpenCV    TODO: get rid of?  Nah this is still here j fine?  Tho doesn't work so gr8 with conda
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"




export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# blender
export PATH="/opt/blender/:$PATH"

# conda
#export PATH="~/anaconda3/bin:$PATH"   # TODO: uncomment.  Was only commented out b/c openpose required us to remove conda

# CGAL
#export CMAKE_BUILD_TYPE="Release"
alias g++='date && printf "=================\n" && g++ -Wall'

# hmr, BodyLabs / Tubingen
alias hmr='source /home/n/Documents/code/hmr/venv_hmr/bin/activate'
alias hmr2='source /home/n/Documents/code/old/hmr/hmr_March_24_2019/bin/activate'
alias SMPLX='conda deactivate && conda activate cat11 && python3 /home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/smplx/examples/demo.py --model-folder $SMPLX_FOLDER --plot-joints=True --gender="female"'
alias homogenus='cd /home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/smplx/_homogenus_____CLICKME/homogenus && conda deactivate && conda activate cat11 && python3 -m homogenus.tf.homogenus_infer -ii ./samples/images/ -io ./samples/images_gendered/ -oi ./samples/openpose_keypoints/ -oo ./samples/openpose_keypoints_gendered/ -tm /home/n/Downloads/homogenus_v1_0/trained_models/tf/'
alias SMPLifyX='python3 smplifyx/main.py --config cfg_files/fit_smplx.yaml --data_folder $DATA_FOLDER --output_folder $OUTPUT_FOLDER --visualize="True"  --model_folder $MODEL_FOLDER --vposer_ckpt $VPOSER_FOLDER --part_segm_fn smplx_parts_segm.pkl --use_cuda False --interpenetration False'

#SMPL_LOCATION=~/Downloads/smpl
SMPL_LOCATION=/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/smpl # NOTE: under git
#export PYTHONPATH=$PYTHONPATH:$SMPL_LOCATION
SMPL_LOCATION2=/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/smpl/smpl_webuser
#export PYTHONPATH=$PYTHONPATH:$SMPL_LOCATION2

# For more details, see https://github.com/vchoutas/smplx .
SMPLX_LOC=/home/n/Downloads/smplx/models
SMPLX_FOLDER=$SMPLX_LOC




alias OP="/home/n/Documents/code/openpose/build/examples/openpose/openpose.bin --help" # "OP" stands for: OpenPose

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/n/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/n/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/n/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/n/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


conda deactivate # b/c it goes in with "conda base" activated (Sun Feb  3 06:35:28 EST 2019)

alias body_viz='source /home/n/Documents/code/kivy_slider/venvs/body_viz/bin/activate'
alias web='conda activate web'
export FLASK_APP=~/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/src/web/grinberg_mega_tutorial/The-Complete-Flask-Mega-Tutorial/CODE/microblog-0.4/microblog.py
alias gb='conda activate flask_mgrinberg'
# HMR
#export PYTHONPATH=$PYTHONPATH:/home/`whoami`/Documents/code/old/hmr
#export PYTHONPATH_HMR=$PYTHONPATH # because HMR has its own python2 chumpy

# chumpy
#export PYTHONPATH=$PYTHONPATH:/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/conda_+/lib/python3.6/site-packages
# measure.py, mesh.py, Go.py
#export PYTHONPATH=$PYTHONPATH:/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018
alias all='source /home/n/hmr___and_web/bin/activate' # TODO: figure out how to get `whoami` in there WITHIN a bash alias
alias z='readlink -f'
alias c='date && printf "=====================\n" && cd'
alias k='ln -s' # NOTE: destination ("endpoint") of link 1st, then source (where the link should be).  Unfortunately, the thing I really always forget is which ORDER the arguments go in, not the `ln -s` part.  But I suppose the fastest way to fix this is to just rapidly try both orders and see which works.  Sometimes I forget whether it's -s or -S, though.
alias sfi='sudo find'
alias fr='find . -printf "%T@ %Tc %p\n" | sort -n' # fr == "find recent."   https://superuser.com/questions/294161/unix-linux-find-and-sort-by-date-modified
alias sg='sudo grep'
alias pw='2;pwd;2'
alias wd='2;pwd;2' # working dir
# TODO: kill password entry for git push
alias x='xclip'
alias lsln='find . -maxdepth 1 -type l -ls' # list all symbolic links  ("ln" because that's the command typed to make a link)
alias lln='find . -maxdepth 1 -type l'
alias lsg='cut -d: -f1 /etc/group | sort'
alias lsgrp='cut -d: -f1 /etc/group | sort'
alias lsgroup='cut -d: -f1 /etc/group | sort'
alias listgroup='cut -d: -f1 /etc/group | sort'
alias listgroups='cut -d: -f1 /etc/group | sort'
alias ts='touch -h'  # TODO: replace this if something you use more should replace it
#alias touch_link='touch -h -t 201301291810 symlink'
#TODO : kill capslock  (it f**ks up commands, both in VIM and bash.)
#TODO: disable caps lock on a Ubuntu-wide level
alias e='echo'
# sample command:
# alias grr='grep -r -i --include \*.py import\   > tests/install_tests/imports.py'     #recursive grep in only files with .py endings
alias grr='grep -nr -i --include \*.py ' # grr stands for "grep recursively (in .py files)"
alias grrjs='grep -nr -i --include \*.js ' # grrjs stands for "grep recursively (all .js files)"
alias gn='grep -v'      # grep negative
alias grnot='grep -v'   # grep negative    (grep exclude [queryName])
alias excludelonglines='grep "^.\{0,300\}$"'
alias listinternet='sudo iptables -L'  # list internet rules
alias interneton='sudo iptables -P INPUT ACCEPT'
alias internetoff='sudo iptables -P INPUT DROP'
alias editcron='sudo vim /etc/crontab' # used to schedule internet on-off, among other automated (timed, regular, etc.) activities
alias bigs='du -hs * | sort -h'
alias dusort='du -hs * .* | sort -h'
alias mouseoff='xinput --disable 11'
alias tboard='tensorboard --logdir=summaries'
# useful cmds
# xinput --disable 11
# tensorboard --logdir=summaries
# echo $LS_COLORS #bash prompt colors
bind -x '"\C-l": spaces; l; fewer_spaces'




#===================================================================================================
# gcloud forwarding, login, etc.
#===================================================================================================

#export CLOUDSDK_CORE_PROJECT=""   https://stackoverflow.com/questions/46770900/how-to-change-the-project-in-gcp-using-cli-commands   (TODO?)   seems unnecessary right now.   Supposed to set the default project in "gcloud compute ..."



#export DISPLAY=localhost:0.0  # I think this only works if you know your IP address???

export DISPLAY=:0.0 # TODO: did this IP address work?  (Wed Jun 19 20:35:44 EDT 2019 - nxb )




# NOTE: TODO:   More variants & useful docker commands at:
# 1.  https://stackoverflow.com/questions/44480740/how-to-save-a-docker-container-state
#   a.
# 2.  https://stackoverflow.com/questions/23735149/what-is-the-difference-between-a-docker-image-and-a-container
# 3.
# 4.
# 5.
# 6.
# 7.
# 8.









# This 'dock1' alias is also helpful for    copying and doing variants
alias dock1='docker run -it --rm --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=0 nxb_working2'
#    docker commit 46947b43d681 nxb_working2
#   sha256:94e035b8d4c6f3dd35b609be61fdf843151f589029265ad3761d610eb5c70c4f

#alias b4w='gcloud compute --project "secret-voice-243500" ssh --ssh-flag=-X --zone "us-east4-c" "cat_macys_vr@blend4web-server-ubuntu14"'
# I called this alias "OPV"   b/c the whole reason I made it was to use OpenPose (OP) on a Virtual (V) machine.
#alias OPV='gcloud compute --project "secret-voice-243500" ssh --ssh-flag=-X --zone "us-central1-a" "cat_macys_vr@openpose-ubuntu-1"'
alias OP2='gcloud compute --project "secret-voice-243500" ssh --ssh-flag=-X --zone "us-central1-a" "cat_macys_vr@openpose-ubuntu16-1"'
#alias S='gcloud compute --project "secret-voice-243500" ssh --ssh-flag=-X --zone "us-east4-c" "cat_macys_vr@upload-nodejs-smplifyx-2"' # 'S' stands for "SMPLify-X."
alias cs231='gcloud compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-east1-d" "cat_macys_vr@cuda-version-test-0-vm"'
alias cs='cs231'
alias VM_SMPLifyX='cs231'
#alias cs231='gcloud compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-east1-d" "cat_macys_vr@torch-smplx-vm"'




#'gcloud compute  ssh --ssh-flag=-X --zone "us-east1-d" "cat_macys_vr@torch-5-vm"'
#'gcloud compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@pytorch-1-vm"'
alias cs231n='gcloud compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@pytorch-1-vm"'
#alias cs231n='gcloud compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@cs231n---pytorch-1-vm"'
#alias cs231_CPU='gcloud compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@cs231n-no-gpu-0-vm"'   # This is my old CPU VM instance, not the one I accidentally stumbled into on August 7, 2019   -nxb

alias cs231_CPU='gcloud compute --project "secret-voice-243500" ssh --ssh-flag=-X --zone "us-west1-b" "cat_macys_vr@cs231n-tensorflow-0-vm"'

#alias cs231_GPU='gcloud compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@cs231n---pytorch-1-vm"'
#alias cs231_GPU='gcloud compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@cs231n---pytorch-1-vm"'
alias cs231_GPU='gcloud compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@pytorch-1-vm"'

#alias majic='gcloud compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@pytorch-1-vm"'









#===================================================================================================
# 1st argument is the tar.xz file name; 2nd argument is the directory.
# Full cmd example: XZ_OPT=-e9 tar cJf cs231n_assn1___up_to_SVM_1st_draft.tar.xz /home/cat_macys_vr/assignment1
alias compress='XZ_OPT=-e9 tar cJf'     


# 1st argument is the tar.xz file name; 2nd argument is the directory.

# cs231n assignment 1:
alias backup1='XZ_OPT=-e9 tar cJf cs231n_assn1.tar.xz /home/cat_macys_vr/assignment1'   # was true for assignment1.
# assignment 2:
alias backup2='XZ_OPT=-e9 tar cJf cs231n_assn2.tar.xz /home/cat_macys_vr/assignment2'
# assn 3:
alias backup3='XZ_OPT=-e9 tar cJf cs231n_assn3.tar.xz /home/cat_macys_vr/assignment3'
alias backup='backup2'

#alias bounce_CIFAR_data='mv ~/assignment1/cs231n/datasets/cifar-10-batches-py/ ~/Downloads/ && sleep 600 && mv ~/Downloads/cifar-10-batches-py/  ~/assignment1/cs231n/datasets/'





alias gcloud='gcloud.cmd'
alias gc='gcloud.cmd'

































































































alias bounce_CIFAR_data='mv ~/assignment1/cs231n/datasets/cifar-10-batches-py/ ~/Downloads/ && sleep 600 && mv ~/Downloads/cifar-10-batches-py/  ~/assignment1/cs231n/datasets/'
alias mv_pkls='mv /home/cat_macys_vr/assignment1/*.pkl ~/Downloads/'
alias bounce1='mv_pkls && bounce_CIFAR_data && mv /home/cat_macys_vr/Downloads/*.pkl /home/cat_macys_vr/assignment1/'



#===================================================================================================
# cs231n: assignment 2:                             CPU, NOT GPU.
#===================================================================================================
alias bounce_cython='mv /home/cat_macys_vr/assignment2/cs231n/build /home/cat_macys_vr/Downloads/ &&\
mv /home/cat_macys_vr/assignment2/cs231n/im2col_cython.cpython-35m-x86_64-linux-gnu.so /home/cat_macys_vr/Downloads/ &&\
mv /home/cat_macys_vr/assignment2/cs231n/im2col_cython.c /home/cat_macys_vr/Downloads/ &&\
mv /home/cat_macys_vr/assignment2/*.pkl /home/cat_macys_vr/Downloads/ &&\
sleep 600 && \
mv /home/cat_macys_vr/Downloads/build /home/cat_macys_vr/assignment2/cs231n/ &&\
mv /home/cat_macys_vr/Downloads/im2col_cython.cpython-35m-x86_64-linux-gnu.so  /home/cat_macys_vr/assignment2/cs231n/  &&\
mv /home/cat_macys_vr/Downloads/im2col_cython.c /home/cat_macys_vr/assignment2/cs231n/ &&\
mv /home/cat_macys_vr/Downloads/*.pkl /home/cat_macys_vr/assignment2/cs231n/ '

alias mvback2='mv /home/cat_macys_vr/Downloads/*.pkl /home/cat_macys_vr/assignment2/ &&\
mv /home/cat_macys_vr/Downloads/im2col_cython.c /home/cat_macys_vr/assignment2/cs231n/ &&\
mv /home/cat_macys_vr/Downloads/im2col_cython.cpython-35m-x86_64-linux-gnu.so  /home/cat_macys_vr/assignment2/cs231n/  &&\
mv /home/cat_macys_vr/Downloads/build /home/cat_macys_vr/assignment2/cs231n/ '

alias bounce2='bounce_cython'
alias bounce='bounce2'
























alias gitpullprep='~/gitfetchpullall.sh'          # contents of that file are:     `git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done'`  
alias gitfetchpullall='gitpullprep && git pull --all && git fetch --all'             # "git fetch pull all"                                
alias gfpa='gitfetchpullall'             # "gfpa" stands for "git fetch pull all"                                































export PATH=$PATH:/home/n/Downloads/node-v10.8.0-linux-x64/bin
#alias m='gcloud compute ssh --ssh-flag=-X nathanbendich@majic-vr-slash-ar-airbnb-1'
alias m='gcloud compute --project "helpful-valve-195602" ssh --ssh-flag='-X' --zone "us-central1-a" "nathanbendich@majic-vr-slash-ar-airbnb-1"'
alias majic='m'
alias cx='gcloud compute ssh --ssh-flag=-X nathanbendich@startup-survey-0-0-1'
alias cxb='gcloud compute ssh --ssh-flag=-X nathanbendich@mgn-3' # the 'b' in "cxb" => BackEnd   -nxb, on      June 13, 2020; at      10:59 P.M. EDT.
#alias cxf='gcloud compute ssh --ssh-flag=-X nathanbendich@startup-survey-0-0-1'   # the 'f' in "cxf" => frontEnd   -nxb, on      June 13, 2020; at      10:59 P.M. EDT.
alias ClothX='cx'
alias cxc='gcloud compute ssh --ssh-flag=-X nathanbendich@mgn-3---zone-west1-b'
# NOTE: how to  use a new name easily enough: `alias cx | cut -c11- | cut -c-63`mgn-0-0-0       here I uas the new instance name "mgn-0-0-0"
alias cxt='gcloud compute ssh --ssh-flag=-X nathanbendich@cx-0-0-0' # "cxt" stands for for "CX Temp".
alias cx1='gcloud compute ssh --ssh-flag=-X nathanbendich@cx-0-0-1' # "cx1" stands for for "CX Temp 1".

alias lis='gcloud compute instances list'
alias sta='gcloud compute instances start startup-survey-0-0-1'
alias sta2='gcloud compute instances start mgn-3'
alias sto='gcloud compute instances stop startup-survey-0-0-1'
alias sto2='gcloud compute instances stop mgn-3'

alias gsu='gsutil ls gs://*'
alias gsls='gsutil ls'


# How to docker:
alias dock='sudo docker run -it --net=host -e DISPLAY 32a767127c27'       # I think DISPLAY is the thing I wanted???  (Tue Jan 14 21:58:07 EST 2020)             where "32..." is the image (container?) ID.
# can also do "sudo docker attach [container_num]"

# `sox` can be used to cut video.
#   ie.  `sox 22_secs_silence.mp3 9.97_secs_silence.mp3 trim 0 9.93`
#   For mp3 support, run `sudo apt-get install libsox-fmt-mp3` .

#alias chomp='perl -pi -e \'chomp if eof\''

#export PATH=$PATH:/home/n/Downloads/node-v10.8.0-linux-x64/bin   # could do this for env var "CLOUDSDK_CORE_PROJECT" as mentioned [here](https://stackoverflow.com/questions/46770900/how-to-change-the-project-in-gcp-using-cli-commands).
export SMPLX_MODEL_FOLDER=/home/nathan_bendich/Downloads/SMPL-X_Models/models/

alias listgroups='cut -d: -f1 /etc/group | sort'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/n/google-cloud-sdk/path.bash.inc' ]; then . '/home/n/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/n/google-cloud-sdk/completion.bash.inc' ]; then . '/home/n/google-cloud-sdk/completion.bash.inc'; fi

alias runelite="java -jar /usr/local/bin/RuneLite.jar"
alias ttr="/home/n/Downloads/Toontown\ Rwritten/Launcher"
export PATH=$PATH:/home/n/Downloads/jdk-17.0.1/jdk-17.0.1/bin

# Stripe:
export PATH=$PATH:/c/Users/natha/Downloads/stripe_1.11.3_windows_x86_64 # ThinkPad x1 Carbon
alias stripe="/c/Users/natha/Downloads/stripe_1.11.3_windows_x86_64/stripe.exe" # ThinkPad x1 Carbon

alias artisan='conda activate artisan'     #'conda activate Artisan_interviews_FastAPI_and_GPT___originally_September_13_2024'   
alias art='artisan'

alias edu='conda activate edu_ai_proj_liao'





# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/heavenlybamboo/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/heavenlybamboo/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/heavenlybamboo/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/heavenlybamboo/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


