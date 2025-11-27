
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


alias info='2 && date && pwd'
alias i='info'
# lisp
alias arc='time /home/n/arc/arc-nu/arc'
#alias arc='/home/n/racket/bin/racket -f /home/n/mz/tmp/arc3.1/as.scm'
#alias arc='/home/n/arc/anarki/arc.sh -n'
alias ra='time /home/n/racket/bin/racket -il xrepl'
alias rac='time /home/n/racket/bin/racket -il xrepl'
alias racket='time /home/n/racket/bin/racket -il xrepl'

# python
#alias p='date && time python'
alias py='info && time python3'
#alias p3='date && time python3'
alias p38='info && time python3.8'
alias p37='info && time python3.7'
alias p36='info && time python3.6'
alias p35='info && time python3.5'
alias p2='info && time python2'
alias jn='jupyter notebook'
alias ipy='ipython'

# virtual envs, conda
# TODO: prune after conda reinstall.  
alias con='info && conda'
alias mag='con activate magicke___March_5_2021_'

alias ca='con activate cat12' # 'source activate cat'   # 12,11, 4 are the working ones right now (Mon Mar  4 13:28:47 EST 2019)
alias ca11='con activate cat11'
alias ca12='con activate cat12'
alias ju='con activate jupyter'
alias c2='con activate cat2' #'source activate cat2'
alias c3='con activate cat_opencv3' #'source activate cat_opencv3'
alias my='con activate my_cat' #'source activate my_cat'
alias cinst='con install'
alias pinst='info && pip install'
alias de='con deactivate' #'source deactivate'
alias ac='con activate'   #'source activate'

# java
alias jv='time java'
alias jc='time javac'

#chmod
alias chmx='info && chmod +x'

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

alias spaces='info && echo "Bash version: ${BASH_VERSION}...";for i in {1..49..1}; do echo ""; done' # TODO: how to change "49" to any N we want?   also NOTE the second "1" in the "for i in {1..49..1}" is the step size (ie. for i in range(1,9,2) in python. 
alias spaces='for i in {1..49}; do echo ""; done'
alias fewer_spaces='for i in {1..29}; do echo ""; done'
alias fewer_fewer_spaces='for i in {1..15}; do echo ""; done'
alias 20='for i in {1..20}; do echo ""; done'
alias 10='for i in {1..10}; do echo ""; done'
alias 9='for i in {1..9}; do echo ""; done'
alias 5='for i in {1..5}; do echo ""; done'
alias 2='for i in {1..2}; do echo ""; done'
alias 1='for i in {1..1}; do echo ""; done'

#    for i in {1..49}; do echo ""; done
# some more ls aliases
#alias l='date && pwd && ls -ltrAh && 2'  # <==   doesn't work for `l filename`
alias l='info && ls -ltrAh' #     old:   alias l='date && pwd && ls -ltrAh   && 2'     <==   doesn't work for `l filename`
alias lt='l | tail'
alias lold='ls -ltAh | tail'

# dirs
alias ldir='l -d */'  # ld is a different command (a "REAL" UNIX command) that I was overwriting
alias ldi='ldir .*/'  # ld is a different command that I was overwriting

alias lwc='l|wc'
alias ltail='l | tail'
alias lhead='l | head'
alias lsize='ls -lSrh'

# ls [type of file]
alias lpy='l *.py'
alias lnpy='l *.npy'
alias lpng='l *.png'
alias ltxt='l *.txt'
alias ljpg='l *.jpg'
alias lswp='l .*.swp'
alias lsh='l *.sh'
alias lpdf='l *.pdf'
alias lmp4='l *.mp4'
alias lcpp='l *.cpp'
alias lc='l *.c'
alias ljava='l *.java'
alias lscala='l *.scala'
alias lsc='l *.sc'
alias lo='l *.o'
alias lrb='l *.rb'
alias lpl='l *.pl'
alias lPL='l *.PL'
alias lsav='l *.sav'
alias ljar='l *.jar'
alias lrtf='l *.rtf'
alias lbmp='l *.bmp'
alias ltif='l *.tif'
alias lsvg='l *.svg'
alias lhtm='l *.htm'
alias lxhtml='l *.xhtml'
alias lphp='l *.php'
alias lWAV='l *.WAV'
alias ltgz='l *.tar.gz'
alias ltar='l *.tar'
alias lbin='l *.bin'
alias liso='l *.iso'
alias lcsv='l *.csv'
alias lxml='l *.xml'
alias ljson='l *.json'
alias ljs='l *.js'
alias lhtml='l *.html'
alias lcss='l *.css'
alias lgif='l *.gif'
alias ljpeg='l *.jpeg'
alias lwebm='l *.webm'
alias lodt='l *.odt'
alias lwav='l *.wav'
alias lmp3='l *.mp3'
alias logv='l *.ogv'
alias lzip='l *.zip'
alias ldeb='l *.deb'
alias lpart='l *.part'
alias lppt='l *.ppt'
alias lpptx='l *.pptx'
alias lodp='l *.odp'
alias lclass='l *.class'
alias llisp='l *.lisp'
alias llsp='l *.lsp'
alias lel='l *.el'
alias lbash='l .bashrc'
alias lvim='l .vimrc'
alias lswift='l *.swift'
alias lvb='l *.vb'
alias lh='l *.h'
alias lcs='l *.cs'
alias lods='l *.ods'
alias lxls='l *.xls'
alias lxlsx='l *.xlsx'
alias lxlr='l *.xlr'
alias lavi='l *.avi'
alias lmov='l *.mov'
alias ltex='l *.tex'
alias l7z='l *.7z'
alias lpyc='l *.pyc'
alias lmd='l *.md'
alias lexe='l *.exe'
alias lso='l *.so'
alias ltargz='l *.tar.gz'
alias lR='l *.R'
alias lmm='l *.mm'
alias lm='l *.m'
alias lM='l *.M'
alias lmat='l *.mat'
alias lts='l *.ts'
alias ltsx='l *.tsx'
alias lVBA='l *.VBA'
alias lkts='l *.kts'
alias lkt='l *.kt'
alias lgo='l *.go'
alias lrs='l *.rs'
alias lrlib='l *.rlib'
alias lhs='l *.hs'
alias llhs='l *.lhs'
alias lpp='l *.pp'
alias lpas='l *.pas'
alias linc='l *.inc'
alias lclj='l *.clj'
alias lcljs='l *.cljs'
alias lcljc='l *.cljc'
alias ledn='l *.edn'
alias lcl='l *.cl'
alias lfasl='l *.fasl'
alias lscm='l *.scm'
alias lss='l *.ss'
alias lhy='l *.hy'
alias llfe='l *.lfe'
alias lhrl='l *.hrl'
alias lerl='l *.erl'
alias lex='l *.ex'
alias lexs='l *.exs'
alias ljl='l *.jl'
alias lrkt='l *.rkt'
alias lrktl='l *.rktl'
alias lrktd='l *.rktd'
alias lscrbl='l *.scrbl'
alias lplt='l *.plt'
alias lcbl='l *.cbl'
alias lcob='l *.cob'
alias lcpy='l *.cpy'
alias lpkl='l *.pkl'
alias lobj='l *.obj'
alias lipynb='l *ipynb'
alias ljn='l *ipynb'
alias lblend='l *blend'
alias lnpz='l *npz .*npz'
alias lsb3='l *sb3'

# stupidity protection against overwrites
alias rm='info && rm -iv'
alias mv='info && mv -iv'
alias cp='info && cp -iv'
    # -inv always does "no clobber"

# dirs
alias mkd='info && mkdir'
alias rmd='info && rm -ri'

# find
alias f='find'

# grep
alias gr='info && grep -n'

# search filenames recursively
alias fgr='info && find . | grep -i'

# history: find old cmds
alias h='info && history && printf "======================\n" && date'
alias hgr='info && date && printf "======================\n" && history | grep'
alias ht='info && date && printf "======================\n" && history | tail'
alias htail='ht'
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
alias cl='clear &&  i && ls -ltrA'
alias clpy='clear && i &&  ls -ltr *.py'
alias clpng='clear && i &&  ls -ltr *.png'
alias clsh='clear && i &&  ls -ltr *.sh'

# git
alias g='info && git'
#alias git='info && git'
alias galias='g config --get-regexp alias'  # technically incomplete, see https://stackoverflow.com/questions/7066325/list-git-aliases
alias gst='g status'
alias gsh='g status | head -n20'
alias gad='g add -f' # goes thru .gitignore
alias gci='g commit -m'
alias gca='g commit -am'  # -a flag  commits all modified files in one step
alias gpus='g push'
alias gpul='g pull'
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
alias g++='info && printf "=================\n" && g++ -Wall'

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
alias web='con activate web'
export FLASK_APP=~/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/src/web/grinberg_mega_tutorial/The-Complete-Flask-Mega-Tutorial/CODE/microblog-0.4/microblog.py
alias gb='con activate flask_mgrinberg'
# HMR
#export PYTHONPATH=$PYTHONPATH:/home/`whoami`/Documents/code/old/hmr
#export PYTHONPATH_HMR=$PYTHONPATH # because HMR has its own python2 chumpy

# chumpy
#export PYTHONPATH=$PYTHONPATH:/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/conda_+/lib/python3.6/site-packages
# measure.py, mesh.py, Go.py
#export PYTHONPATH=$PYTHONPATH:/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018
alias all='source /home/n/hmr___and_web/bin/activate' # TODO: figure out how to get `whoami` in there WITHIN a bash alias
alias z='readlink -f'
alias c='info && printf "=====================\n" && cd'
alias k='i && ln -s' # NOTE: destination ("endpoint") of link 1st, then source (where the link should be).  Unfortunately, the thing I really always forget is which ORDER the arguments go in, not the `ln -s` part.  But I suppose the fastest way to fix this is to just rapidly try both orders and see which works.  Sometimes I forget whether it's -s or -S, though.
alias sfi='sudo find'
#doesn't work on mac:   alias fr='find . -printf "%T@ %Tc %p\n" | sort -n' # fr == "find recent."   https://superuser.com/questions/294161/unix-linux-find-and-sort-by-date-modified
alias fr='find . -type f -print0 | xargs -0 ls -tlr'     # https://superuser.com/questions/298832/how-do-i-get-files-found-by-command-line-find-ordered-by-modification-date-in       for filetypes, see below.    
alias frtxt='find . -type f -name "*.txt" -print0 | xargs -0 ls -tlr'
alias frpy='find . -type f -name "*.py" -print0 | xargs -0 ls -tlr'
alias sg='sudo grep'
alias pw='2;info;2;pwd'
alias wd='2;info;2;pwd' # working dir
# TODO: kill password entry for git push
alias x='xclip'
alias lsln='info && find . -maxdepth 1 -type l -ls' # list all symbolic links  ("ln" because that's the command typed to make a link)
alias lln='info && find . -maxdepth 1 -type l'
alias lsg='cut -d: -f1 /etc/group | sort'
alias lsgrp='cut -d: -f1 /etc/group | sort'
alias lsgroup='cut -d: -f1 /etc/group | sort'
alias listgroup='cut -d: -f1 /etc/group | sort'
alias listgroups='cut -d: -f1 /etc/group | sort'
alias ts='i && touch -h'  # TODO: replace this if something you use more should replace it
#alias touch_link='touch -h -t 201301291810 symlink'
#TODO : kill capslock  (it f**ks up commands, both in VIM and bash.)
#TODO: disable caps lock on a Ubuntu-wide level
alias e='info && echo'
# sample command:
# alias grr='grep -r -i --include \*.py import\   > tests/install_tests/imports.py'     #recursive grep in only files with .py endings
alias grr='info && grep -nr -i --include \*.py ' # grr stands for "grep recursively (in .py files)"
alias grrpy='grr'
alias grrjs='info && grep -nr -i --include \*.js ' # grrjs stands for "grep recursively (all .js files)"
alias grre='info && grep -nri '
alias gn='grep -v'      # grep negative
alias grnot='grep -v'   # grep negative    (grep exclude [queryName])
alias excludelonglines='grep "^.\{0,300\}$"'
alias listinternet='sudo iptables -L'  # list internet rules
alias interneton='sudo iptables -P INPUT ACCEPT'
alias internetoff='sudo iptables -P INPUT DROP'
alias editcron='sudo vim /etc/crontab' # used to schedule internet on-off, among other automated (timed, regular, etc.) activities
alias bigs='info && du -hs * | sort -h'
alias dusort='info && du -hs * .* | sort -h'
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







#alias gcloud='info && gcloud.cmd'
alias gc='info && gcloud.cmd'









# This 'dock1' alias is also helpful for    copying and doing variants
alias dock1='docker run -it --rm --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=0 nxb_working2'
#    docker commit 46947b43d681 nxb_working2
#   sha256:94e035b8d4c6f3dd35b609be61fdf843151f589029265ad3761d610eb5c70c4f

#alias b4w='gc compute --project "secret-voice-243500" ssh --ssh-flag=-X --zone "us-east4-c" "cat_macys_vr@blend4web-server-ubuntu14"'
# I called this alias "OPV"   b/c the whole reason I made it was to use OpenPose (OP) on a Virtual (V) machine.
#alias OPV='gc compute --project "secret-voice-243500" ssh --ssh-flag=-X --zone "us-central1-a" "cat_macys_vr@openpose-ubuntu-1"'
alias OP2='gc compute --project "secret-voice-243500" ssh --ssh-flag=-X --zone "us-central1-a" "cat_macys_vr@openpose-ubuntu16-1"'
#alias S='gc compute --project "secret-voice-243500" ssh --ssh-flag=-X --zone "us-east4-c" "cat_macys_vr@upload-nodejs-smplifyx-2"' # 'S' stands for "SMPLify-X."
alias cs231='gc compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-east1-d" "cat_macys_vr@cuda-version-test-0-vm"'
alias cs='cs231'
alias VM_SMPLifyX='cs231'
#alias cs231='gc compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-east1-d" "cat_macys_vr@torch-smplx-vm"'




#'gc compute  ssh --ssh-flag=-X --zone "us-east1-d" "cat_macys_vr@torch-5-vm"'
#'gc compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@pytorch-1-vm"'
alias cs231n='gc compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@pytorch-1-vm"'
#alias cs231n='gc compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@cs231n---pytorch-1-vm"'
#alias cs231_CPU='gc compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@cs231n-no-gpu-0-vm"'   # This is my old CPU VM instance, not the one I accidentally stumbled into on August 7, 2019   -nxb

alias cs231_CPU='gc compute --project "secret-voice-243500" ssh --ssh-flag=-X --zone "us-west1-b" "cat_macys_vr@cs231n-tensorflow-0-vm"'

#alias cs231_GPU='gc compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@cs231n---pytorch-1-vm"'
#alias cs231_GPU='gc compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@cs231n---pytorch-1-vm"'
alias cs231_GPU='gc compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@pytorch-1-vm"'

#alias majic='gc compute --project "secret-voice-243500" ssh --ssh-flag='-X' --zone "us-west1-b" "cat_macys_vr@pytorch-1-vm"'









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
#alias m='gc compute ssh --ssh-flag=-X nathanbendich@majic-vr-slash-ar-airbnb-1'
alias m='gc compute --project "helpful-valve-195602" ssh --ssh-flag='-X' --zone "us-central1-a" "nathanbendich@majic-vr-slash-ar-airbnb-1"'
alias majic='m'
alias cx='gc compute ssh --ssh-flag=-X nathanbendich@startup-survey-0-0-1'
alias cxb='gc compute ssh --ssh-flag=-X nathanbendich@mgn-3' # the 'b' in "cxb" => BackEnd   -nxb, on      June 13, 2020; at      10:59 P.M. EDT.
#alias cxf='gc compute ssh --ssh-flag=-X nathanbendich@startup-survey-0-0-1'   # the 'f' in "cxf" => frontEnd   -nxb, on      June 13, 2020; at      10:59 P.M. EDT.
alias ClothX='cx'
alias cxc='gc compute ssh --ssh-flag=-X nathanbendich@mgn-3---zone-west1-b'
# NOTE: how to  use a new name easily enough: `alias cx | cut -c11- | cut -c-63`mgn-0-0-0       here I uas the new instance name "mgn-0-0-0"
alias cxt='gc compute ssh --ssh-flag=-X nathanbendich@cx-0-0-0' # "cxt" stands for for "CX Temp".
alias cx1='gc compute ssh --ssh-flag=-X nathanbendich@cx-0-0-1' # "cx1" stands for for "CX Temp 1".

alias lis='gc compute instances list'
alias sta='gc compute instances start startup-survey-0-0-1'
alias sta2='gc compute instances start mgn-3'
alias sto='gc compute instances stop startup-survey-0-0-1'
alias sto2='gc compute instances stop mgn-3'

alias gsu='i && gsutil ls gs://*'
alias gsls='i && gsutil ls'


# How to docker:
alias dock='i && sudo docker run -it --net=host -e DISPLAY 32a767127c27'       # I think DISPLAY is the thing I wanted???  (Tue Jan 14 21:58:07 EST 2020)             where "32..." is the image (container?) ID.
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

alias runelite="i && java -jar /usr/local/bin/RuneLite.jar"
alias ttr="i && /home/n/Downloads/Toontown\ Rwritten/Launcher"
export PATH=$PATH:/home/n/Downloads/jdk-17.0.1/jdk-17.0.1/bin

# Stripe:
export PATH=$PATH:/c/Users/natha/Downloads/stripe_1.11.3_windows_x86_64 # ThinkPad x1 Carbon
alias stripe="i && /c/Users/natha/Downloads/stripe_1.11.3_windows_x86_64/stripe.exe" # ThinkPad x1 Carbon

alias artisan='con activate artisan'     #'conda activate Artisan_interviews_FastAPI_and_GPT___originally_September_13_2024'   
alias art='artisan'

alias edu='con activate edu_ai_proj_liao'







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












# Boosted.AI aliases, details, etc. :        
. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion bash)"
alias p='info && time python3.12'      		# 3.12 is Boosted's python version             
alias p3='info && time python3.12'     		# 3.12 is Boosted's python version             
alias p31='info && time python3.12'    		# 3.12 is Boosted's python version             
alias p312='info && time python3.12'   		# 3.12 is Boosted's python version             
alias python31='info && time python3.12'    # 3.12 is Boosted's python version             
alias python312='info && time python3.12'   # 3.12 is Boosted's python version             

# jdk installed w/ brew install --cask temurin17
# see https://github.com/AdoptOpenJDK/homebrew-openjdk
export JAVA_HOME=$(/usr/libexec/java_home -v17)

alias service='info && source /Users/n/Documents/code/agent-service/agent-service/bin/activate'
alias se='info && service'











export PATH=$PATH:/Users/n/Downloads/node-v20.9.0-darwin-arm64/bin  # node



# JWT : 

#PYTHONPATH=. uv run python3 scripts/generate_token.py -j eyJ...    
#export JWT=ey...       # https://alfa.boosted.ai/account-management/users 		(for ALFA)  -Sept 26, 2025                                   # https://alfa.boosted.ai/account-management/users 		(for ALFA)  -Sept 26, 2025                       

#export JWT=ey...      non-FactSet Dev: sept 30     
#export JWT=ey...      # Non-FactSet prod, October 9, 2025
#export JWT=ey...   # FactSet prod, October 10, 2025
export JWT=eyJhbGciOiJSUzI1NiIsImtpZCI6IjRaM09iUTZydmRtdUE4ejBvNmJ4S25JMmdFZ3FjSWwzQ1FfOUVUY3hhY0EiLCJ0eXAiOiJKV1QifQ.eyJib29zdGVkOmJpbGxpbmdfY3VzdG9tZXJfaWQiOiJjOGM2ZTRhZS03NjYyLTQ0NDQtYmFlOC02ZjJmZTc0OTAxNTkiLCJib29zdGVkOmVtYWlsIjoibmF0aGFuLmJlbmRpY2hAYm9vc3RlZC5haSIsImJvb3N0ZWQ6Z2xvYmFsX3VzZXJfaWQiOiI1ODk3YWFiYi01MGUxLTQwYTQtYTBmMy1lYzliZTBmMjBmYzMiLCJib29zdGVkOmhhc19hbGZhX2FjY2VzcyI6dHJ1ZSwiYm9vc3RlZDpoYXNfY29nbml0b19hY2Nlc3MiOnRydWUsImJvb3N0ZWQ6aXNfd2FpdGxpc3RlZCI6ZmFsc2UsImJvb3N0ZWQ6bmFtZSI6Ik5hdGhhbiBCZW5kaWNoIiwiYm9vc3RlZDpvcmdfaWQiOiIxMDFmN2E4Ny05MTM4LTQ0NTgtOGUwZC02MThhOGUxMTgyNmQiLCJib29zdGVkOnJlYWxfdXNlcl9pZCI6bnVsbCwiYm9vc3RlZDp0ZWFtX2lkIjoiNTY4MmQ1M2QtMGM3NC00YzBjLTg5OWMtMTk3YjI3MmM2ZDhlIiwiYm9vc3RlZDp1c2VybmFtZSI6Im5hdGhhbi5iZW5kaWNoQGJvb3N0ZWQuYWkiLCJjb2duaXRvOmdyb3VwcyI6WyJtYW51YWwtYWNjb3VudC1vdmVycmlkZS1iYXNpYyIsImFsZmEtYWdlbnQtYWRtaW4iLCJhY2NvdW50LW1hbmFnZXIiLCJtYW51YWwtYWNjb3VudC1vdmVycmlkZS1mdWxsIiwiaXNfYm9vc3RlZF9zdXBwb3J0Il0sImV4cCI6MTc2MDc5NTg3NSwiaWF0IjoxNzYwNzA5NDc1LCJpc3MiOiJodHRwczovL2Jvb3N0ZWQuYWkiLCJqdGkiOiI4ZjQyZDQ5Mi04OTk4LTQxNGItOTIxZC0zMDFjODAwM2UzY2EiLCJzdWIiOiIwNDQxODZiNy0yNGEwLTQwZmMtYjUwYi1jNWU1MTRiMmNlMTQifQ.nQDVhD2DqZVDPcOJo23CYrH01miBq-8iNPwNLP22pxBm_76HFoyCd7_TzNhwEGRnwKKMzEwY0bcGBP46_rya5QC7I4AutD4Lzd2eVHekrrGuybNfyzba7Bj84JD4q-kK89Kvhsp8HVdcep6_BZjvAaIsAwWxFD51N52j03cvtXBy5FftzHW6PadfUw62swH2EjmVLnoCLr3Vq5eXUMD6-miKoQxpoXUtA-B-ODvHwHUmusu5hUDsgKZe6L0d-o6bNUT0qaba6nb6kliH38V7kJvERwVtD75_DEbXi6eqJrmVAHbUJRDQuHB2bAbAmqGxVQx4m2S6xJlYe25uDJNkww        # non FactSet prod, October 17, 2025                  
#export JWT=eyJhbGciOiJSUzI1NiIsImtpZCI6InZRczAtZk9kT0Q3OXBCZXh5cEcwamhKQnlHVUtEWUIwTEVPYWFOdlJPR0kiLCJ0eXAiOiJKV1QifQ.eyJib29zdGVkOmJpbGxpbmdfY3VzdG9tZXJfaWQiOiJkODkxMTRlOS1mMWYwLTQ5YzAtYmZhMi1iZGY3MDA2ZGRkYjgiLCJib29zdGVkOmVtYWlsIjoibmF0aGFuLmJlbmRpY2grZGV2QGJvb3N0ZWQuYWkiLCJib29zdGVkOmdsb2JhbF91c2VyX2lkIjoiOTI4MTUyYzEtNGY2My00NDkyLWEyMTEtOTRjMTg0ODFlMzJjIiwiYm9vc3RlZDpoYXNfYWxmYV9hY2Nlc3MiOnRydWUsImJvb3N0ZWQ6aGFzX2NvZ25pdG9fYWNjZXNzIjp0cnVlLCJib29zdGVkOmlzX3dhaXRsaXN0ZWQiOmZhbHNlLCJib29zdGVkOm5hbWUiOiJOYXRoYW4gQmVuZGljaCIsImJvb3N0ZWQ6b3JnX2lkIjoiNDBiYjllNjMtNTcxOS00NDNjLWFhZDEtMzI3MGMwZDIzN2U1IiwiYm9vc3RlZDpyZWFsX3VzZXJfaWQiOm51bGwsImJvb3N0ZWQ6dGVhbV9pZCI6IjZlNzJlNWM5LWJkMDctNGU2NC1hZTUyLWE4YjEyMzRjZDc4NyIsImJvb3N0ZWQ6dXNlcm5hbWUiOiJuYXRoYW4uYmVuZGljaCtkZXZAYm9vc3RlZC5haSIsImNvZ25pdG86Z3JvdXBzIjpbIm1hbnVhbC1hY2NvdW50LW92ZXJyaWRlLWJhc2ljIiwiYWxmYS1hZ2VudC1hZG1pbiIsImFjY291bnQtbWFuYWdlciIsIm1hbnVhbC1hY2NvdW50LW92ZXJyaWRlLWZ1bGwiLCJpc19ib29zdGVkX3N1cHBvcnQiXSwiZXhwIjoxNzYwNjI0MDI1LCJpYXQiOjE3NjA1Mzc2MjUsImlzcyI6Imh0dHBzOi8vYm9vc3RlZC5haSIsImp0aSI6IjcyMWRmYTkyLTI5M2UtNDUxMi1hODk2LWQ2MWE4YmIzNWYwYSIsInN1YiI6IjQ5ODNiNjBmLTY4N2QtNDllYi1hOTNkLTA0NGI2ZjNiMzg1YiJ9.RAOEtBBX6NURwN4LcLV9L-sK8GdcQ_kC3EJfFmazRVkxy-o0gSorcQzEQOOx75WkyHgPemYBqELzDSJPBJ0tmLngXoXTbUk1LXRvxvJV5powL8ZBFkxWkvXKi_ROfwmMr7B5WN3NfRuxabapJdRqOnetfWKSpir_BziXfr_q6N0Wsw5_PYM2nk4in938G51DZw44v3lWzCftixFCUoAZFS7YgvGHSN2XTYaHbSH_GgE80psPOkMW8xWUaTSTnimSFDYi6DMxfimANgQhsSlO32Om_Dk7wNzs_kCTuN0LrUuOhY0dKbvIcIYzOqYvCCPA26-SLuopWDEGuNk8AjEp0Q     # non FactSet dev; October 15, 2025
#export JWT=eyJhbGciOiJSUzI1NiIsImtpZCI6IjhjM2U2OWZkLTA4YmItNDBmYi05MWM1LWYxMjBkOGExOGYwMyIsInR5cCI6IkpXVCJ9.eyJib29zdGVkOmJpbGxpbmdfY3VzdG9tZXJfaWQiOiJjOGM2ZTRhZS03NjYyLTQ0NDQtYmFlOC02ZjJmZTc0OTAxNTkiLCJib29zdGVkOmVtYWlsIjoibmF0aGFuLmJlbmRpY2hAYm9vc3RlZC5haSIsImJvb3N0ZWQ6Z2xvYmFsX3VzZXJfaWQiOiI2NGZlYjkyNy00NmIwLTQ5MTQtOGNmMC01MjdlMmU2NWQ2M2QiLCJib29zdGVkOmhhc19hbGZhX2FjY2VzcyI6dHJ1ZSwiYm9vc3RlZDpoYXNfY29nbml0b19hY2Nlc3MiOnRydWUsImJvb3N0ZWQ6aXNfd2FpdGxpc3RlZCI6ZmFsc2UsImJvb3N0ZWQ6bmFtZSI6Ik5hdGhhbiBCZW5kaWNoIiwiYm9vc3RlZDpvcmdfaWQiOiIxMDFmN2E4Ny05MTM4LTQ0NTgtOGUwZC02MThhOGUxMTgyNmQiLCJib29zdGVkOnJlYWxfdXNlcl9pZCI6bnVsbCwiYm9vc3RlZDp0ZWFtX2lkIjoiNTY4MmQ1M2QtMGM3NC00YzBjLTg5OWMtMTk3YjI3MmM2ZDhlIiwiYm9vc3RlZDp1c2VybmFtZSI6Im5hdGhhbi5iZW5kaWNoQGJvb3N0ZWQuYWkiLCJjb2duaXRvOmdyb3VwcyI6WyJhbGZhLWFnZW50LWFkbWluIiwibWFudWFsLWFjY291bnQtb3ZlcnJpZGUtZnVsbCIsIm1hbnVhbC1hY2NvdW50LW92ZXJyaWRlLWJhc2ljIiwiYWNjb3VudC1tYW5hZ2VyIl0sImV4cCI6MTc2MDYyNDIwNSwiaWF0IjoxNzYwNTM3ODA1LCJpc3MiOiJodHRwczovL2Jvb3N0ZWQuYWkiLCJqdGkiOiI2MWFjOTk4OS1hMjQxLTRmZTUtYmNmNi01NDFjYjMyMjM4MjgiLCJzdWIiOiIxM2RmYTg4Yi04MDQ0LTQ3MDEtOTZhNC1hMmQzYTI5YTg2YmUifQ.Beq-V5cy-wtJZbX-Xn3LnMV49y0TW27xlp49qDrBhydRGjvL7kwnHARGT_fhM0QsNPH4OED5kKaCuSmR_FuSq30lqP7c1SHeVP6F0kvgJs5XA6i1InJAyDiPqC1188MygYMkaw4aWSD_lqiO3pzZMEZabR-XbjE0_zi7HjjIVPfUMWylDLLcdB6H_GRBCDc9lf12IoH0VkXaVbzMVYJnI2ENL8tMn_E1FXECgBEsM-h3SNIzSx0ytrME1o6l2LC6224N2VNvG_GM6IprI8A7jVHfyEtYiMUlz4GLHG7lOBJuTFsWP0IK7SI5Z3mxE0cpHWZDTI8RX_Gde_sT2flLLkrpijzA1xVQ8ATNB46bTq2woDyJrok-QAsZs8TaVPgAbf0D85jEOAgkDTMkAB2nIxjppSPneTgNRqLKiA311OTBHVspA8IpbiNTkI4tS0EAcluX4Gv_3kvhVmJAxxsy9dx3568KCq_ipMVTaBEq95om27YWWjPxK8dRLZ9TdC5cLQ1MZbIt8WHq1OUNQPqxQnBMnhnmnmsXHyoLV8ZTq4aXZ8d0j4A2yvu6Mskdfzg8Y9FOlbVrENp0ThEbsipH_i-XuAoZfXTTQ4no0q2kHaOjjkRzfUW6R37t0e_7a9z48L_-rKebmSKAxbsrazaFhUhfTxAFVB2qmdkr574BK8Y     # FactSet prod; October 15, 2025
#export JWT=eyJhbGciOiJSUzI1NiIsImtpZCI6ImQ1Y2M5MjJkLWY2OWMtNDJmZC04NzQwLWQ5M2M5MzdjOTczMyIsInR5cCI6IkpXVCJ9.eyJib29zdGVkOmJpbGxpbmdfY3VzdG9tZXJfaWQiOiJkODkxMTRlOS1mMWYwLTQ5YzAtYmZhMi1iZGY3MDA2ZGRkYjgiLCJib29zdGVkOmVtYWlsIjoibmF0aGFuLmJlbmRpY2grZGV2QGJvb3N0ZWQuYWkiLCJib29zdGVkOmdsb2JhbF91c2VyX2lkIjoiMTJlYTUwMTctOGNiZS00MjI5LThlMTUtZWM3YzkwNDU3NTlmIiwiYm9vc3RlZDpoYXNfYWxmYV9hY2Nlc3MiOnRydWUsImJvb3N0ZWQ6aGFzX2NvZ25pdG9fYWNjZXNzIjp0cnVlLCJib29zdGVkOmlzX3dhaXRsaXN0ZWQiOmZhbHNlLCJib29zdGVkOm5hbWUiOiJOYXRoYW4gQmVuZGljaCIsImJvb3N0ZWQ6b3JnX2lkIjoiNDBiYjllNjMtNTcxOS00NDNjLWFhZDEtMzI3MGMwZDIzN2U1IiwiYm9vc3RlZDpyZWFsX3VzZXJfaWQiOm51bGwsImJvb3N0ZWQ6dGVhbV9pZCI6IjZlNzJlNWM5LWJkMDctNGU2NC1hZTUyLWE4YjEyMzRjZDc4NyIsImJvb3N0ZWQ6dXNlcm5hbWUiOiJuYXRoYW4uYmVuZGljaCtkZXZAYm9vc3RlZC5haSIsImNvZ25pdG86Z3JvdXBzIjpbIm1hbnVhbC1hY2NvdW50LW92ZXJyaWRlLWZ1bGwiLCJtYW51YWwtYWNjb3VudC1vdmVycmlkZS1iYXNpYyIsImFsZmEtYWdlbnQtYWRtaW4iXSwiZXhwIjoxNzYwNjI0NDA4LCJpYXQiOjE3NjA1MzgwMDgsImlzcyI6Imh0dHBzOi8vYm9vc3RlZC5haSIsImp0aSI6IjE4YTAxOWUyLWNlMGUtNDRlZC04YTVmLTVlZmE2OTA4NjlhZiIsInN1YiI6ImMyNjUzOTg3LTA3NzAtNDlhYi1iODBmLTNmZGE2NmY1YzZjZSJ9.H90DCvEQ7m-PH1LtsO1N7cPqodbDV1BDu0N3yOdB5OX_KHru0aPYhWreb-xDlNdaLTT8PuiE2xDYQ-dbLvDK8fGm-unlNbfz5Tois57Ds9vMZyaawMakx7k5CO0K0SnrK0rz0NoMWHLm84-oPasWYaTGYMj3mGVzH8b0yxYfjg9ZIkzOG8tID7tl5YZRQ2oiJyiYfFtIRVBfHAqtMSG82vVK4xOhaurETqx8Fa6QJJlaqoCaR1c4MUSijQI5uyvkSqUj_s3eRKwMfTEcDvJuhZVUXy6FXOKDjrk-ZO02xjDofPv-A1BBjcUlCFJOz-lkQEVauYGqe4gw8KQPRHwN7oDnog8fWV5Nygp8rz4NFAKrpQgEFhjuK5aAXQGX4NnP2nZcNDUnd_hJZcuJ8TRCu_dWSjVkSZFJZmVFtW66L-p9LFTZSuBOPQmBK_uFJziDJj2aIojF8XYbuGExYx-ZVt9i1qKZasWKH88I01cYldNKol4UhoUGvGqRK77Cnv5F6nBuISCy6JQSq--nwPcWrSikCu0s3NomNjZG2EFckudWTfj3IDBSwStBDF8c7-OJWu2Kb8v1tsVdIhXwFMdWjEO-ym_wXtyIP9xmEOAdwMjm0UcVX3RaeCyu0foa06z6LhOkBC4ZXd6_HvMLuzGGPFcpvUyBUzHDiFqdAbwpDiA  #FactSet dev; October 15, 2025      



#  Default to Julian's startup script instead of .                        

###################################################################################################
#   Boosted:                                                                                      #
###################################################################################################
#/Users/n/Documents/code/agent-service-code/agent-service				# handles the back end web side                     
#uv run run_plan_task.py --env ALPHA -r 85dc29ce-da4d-4916-982a-8e2c0b28b989

#/Users/n/Documents/code/agent-web				# handles the front end web side                     
#npm run dev:local
#boosted_jwt.ALPHA     <=====   this means PROD                           

#JWT=ey...      #  factset-dev      Oct. 1, 2025 
#JWT=ey...     #factset-prod, Oct. 1, 2025



# From Utkarsh, fixes a BUNCH of permissions errors, other stuff, etc.:                       
export REDIS_HOST=localhost
export REDIS_QUEUE_HOST=localhost
#export REDIS_HOST=master.boosted-redis-cache-prod.5vekgx.usw2.cache.amazonaws.com
#               //"REDIS_QUEUE_HOST": "master.boosted-redis-cache-prod.5vekgx.usw2.cache.amazonaws.com", //"localhost",
#               //"REDIS_PORT": "6379",
export ENVIRONMENT=ALPHA
export NAMESPACE=insights-backend-prod












# To get native VS Code's debugger working (https://search.brave.com/search?q=vs+code+debugger+ConnectionRefusedError%3A+%5BErrno+61%5D+Connection+refused&source=web&summary=1&conversation=27e55d09d37aacb16f7bd0):                  
export DEBUGPY_PROCESS_SPAWN_TIMEOUT=500  # seconds         
export PYTHONPATH=/Users/n/Documents/code/agent-service-code/agent-service/.venv/bin             # ${workspaceFolder}",     a     



















































































