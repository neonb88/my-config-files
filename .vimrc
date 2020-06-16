"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

" http://vimdoc.sourceforge.net/htmldoc/starting.html#vimrc



let mapleader="U"

" escape keys 
:imap jk <Esc>
:imap jK <Esc>
:imap Jk <Esc>
:imap JK <Esc>
:imap kj <Esc>
:imap kJ <Esc>
:imap Kj <Esc>
:imap KJ <Esc>
" TODO:   figure out a way to easily type a single k or j quickly.  Maybe spacebar?
" NOTE: my reply, after many months/years of 'vim-ing' is to do kkj or jjk

" mouse
"set mouse=a

" Save and/or quit different types of files:
:map K :wa<Return>
:map <leader>Y :xa<Return>
:map <leader><leader>Y :qa<Return>
:map Q :qa<Return>
:map <leader>Z :bp<Return>
:map <leader>X :bp<Return>
" To exit ex mode (if you accidentally type ':i'), type just a single dot:  '.'
"   src: https://www.google.com/search?q=enter+ex+mode&oq=enter+ex+mode&aqs=chrome..69i57.1836j0j0&client=ubuntu&sourceid=chrome&ie=UTF-8


":nmap <Return> i<Return><Esc>  " this also works (':nmap')
:map <Return> i<Return><Esc>
:map <Tab> i<Tab><Esc>l
":map <Tab> EBi<Tab><Esc>l
:map <Space> i<Space><Esc>
:map <Backspace> i<Backspace><Esc>l

set tabstop=2    "4
set shiftwidth=2 "4
set expandtab    " should I use tabs instead of spaces?  See: Richard Hendricks of 'Silicon Valley' fame
set ai "autoindent
set ruler

autocmd FileType make setlocal noexpandtab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set backupdir^=~/.backup  " this option was here before.  (Sat May 16 00:14:34 EDT 2020)
" vim backups 'howto' in https://gist.github.com/nepsilon/003dd7cfefc20ce1e894db9c94749755
"Turn on backup option
set backup

"Where to store backups
set backupdir=~/.vim/backup//

"Make backup before overwriting the current buffer
set writebackup

"Overwrite the original backup file
set backupcopy=yes

"Meaningful backup name, ex: filename@2015-04-05.14:59:00
"au BufWritePre * let &bex = '@' . strftime("%F.%H:%M:%S")
"Meaningful backup name, ex: filename@2015-04-05.14:59
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
" More on 'strftime' : http://www.cplusplus.com/reference/ctime/strftime/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Prevents problems with caps lock / shift-causing-weird-capitalization
:command WQ wq
:command Wq wq
:command Q q
:command U u
:command W w

:command Resize res
:command RESIZE res
:command Res res
:command RES res

" Shortcutting split navigation, saving a keypress:
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

" Shortcutting split resizing, saving a keypress:
  map <leader>P :res<Space>+1<Return>
  map <leader>M :res<Space>-1<Return>
  map <leader>L :vertical<Space>resize<Space>+1<Return>
  map <leader>R :vertical<Space>resize<Space>-1<Return>
" I used leader instead of 'ctrl' b/c <C-o> is useful
  map <leader>O o1.<Return><Space><Space>a.<Return><Backspace><Backspace>2.<Return>3.<Return>4.<Return>5.<Return>6.<Return>7.<Return>8.<Return>9.<Return>10.<Return>11.<Return>12.<Return>13.<Return>14.<Return>15.<Return>16.<Return>17.<Return>18.<Esc>
  " 'O' for 'Outline'
  map <leader>I oa.<Return>b.<Return>c.<Return>d.<Return>e.<Return>f.<Return>g.<Return>h.<Return>i.<Return>j.<Return>k.<Return>l.<Return>m.<Return>n.<Return>o.<Return>p.<Return>q.<Return>r.<Return>s.<Return>t.<Return>u.<Return>v.<Return>w.<Return>x.<Return>y.<Return>z.<Esc>
  " 'I' just because it's close to 'U.'
" above is the precursor to my fancier general outline-producer.  It oughta work well enough for my current purposes

" Copy things from Ubuntu 16.04 system clipboard into vim with shift+insert   (or right click + 'paste')


let @s = 'A;jkJ'
let @m = 'iif __name__=="__main__":jko  '
let @f = 'ifuncname=sys._getframe().f_code.co_namejkoprint("entered function ",funcname)'

" :set paste  " lets us paste from the Ubuntu system clipboard with proper indentation   like we would in gedit
" :set nopaste
"make if __name__=="__main__": a leader cmd rather than a macro


" save/recover vim screen setup in 1 (2) keystrokes: https://stackoverflow.com/questions/1416572/vi-vim-restore-opened-files
" Quick write session with F2
map <F2> :mksession! ~/.vim_session <cr>
" And load session with F3
map <F3> :source ~/.vim_session <cr>
" This line (source ~/.vim_session) is giving me problems on a GCloud Compute Instance.  (the HIDDEN file version, not the visible file one)



" Remap 'kill process' which is normally the restuls of ctrl+Z  (I don't want to lose my vimsessions prematurely)
  map <C-z> 0



set scrolloff=5         " keep 5 lines when scrolling
" TODO:  bp    (prev buffer)
" TODO: python strings NOT IN PURPLE.  hard to read.
set showcmd
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching

"set visualbell t_vb=    " turn off error beep/flash
"set novisualbell        " turn off visual bell

syntax on               " turn syntax highlighting on by default
filetype on             " detect type of file






" highlighting:
:syntax on " highlighting




:map <leader>V :vertical resize<Return>
:map <leader>F :res<Return>
:map <leader>T :res<Return>:vertical resize<Return>
:map <leader>S :sp<Return>
:map <leader>D :vs<Return>
:map <leader>N :set nopaste<Return>
:map <leader>B :set paste<Return>




" These cmds should copy to / paste from  system clipboard :  
" 1.  https://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard    
" 2.  https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
:map <Leader>y "*y
:map <Leader>p "*p
:map <Leader>d "*d

" This will get in the way of my mapping UY => :xa
:map <Leader>Y "+y  
:map <Leader>D "*D
:map <Leader>P "+p
"  It's probably better to just remember how to use the registers.  -nxb, June 16, 2020

































































