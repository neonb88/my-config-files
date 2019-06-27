"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|



let mapleader="U"

" escape keys 
:imap jk <Esc>
:imap jK <Esc>
:imap Jk <Esc>
:imap JK <Esc>
" more escape keys 
:imap kj <Esc>
:imap kJ <Esc>
:imap Kj <Esc>
:imap KJ <Esc>
" TODO:   figure out a way to easily type a single k or j quickly.  Maybe spacebar?
":imap kk <Esc>
":imap kK <Esc>
":imap Kk <Esc>
":imap KK <Esc>
":imap jj <Esc>
":imap jJ <Esc>
":imap Jj <Esc>
":imap JJ <Esc>

:map <Return> i<Return><Esc>
:map <Tab> i<Tab><Esc>l
":map <Tab> EBi<Tab><Esc>l
:map <Space> i<Space><Esc>
:map <Backspace> i<Backspace><Esc>l

set tabstop=2    "4
set shiftwidth=2 "4
set expandtab    " should I use tabs instead of spaces?  See: Richard Hendricks of 'Silicon Valley' fame
set autoindent

autocmd FileType make setlocal noexpandtab
set backupdir^=~/.backup

:command WQ wq
:command Wq wq
:command Q q
:command U u
:command W w

" Shortcutting split navigation, saving a keypress:
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

" Shortcutting split resizing, saving a keypress:
  map <leader>P :res<Space>+1<Return>
  map <leader>M <C-w>-
  map <leader>L :vertical<Space>resize<Space>+1<Return>
  map <leader>R :vertical<Space>resize<Space>-1<Return>
" TODO: use leader instead of 'ctrl' b/c <C-o> is useful
" TODO:   debug enter (used to work just fine, now doesn't).  Prob has something to do with these most recent additions
  map <leader>O o1.<Return><Space><Space>a.<Return><Backspace><Backspace>2.<Return>3.<Return>4.<Return>5.<Return>6.<Return>7.<Return>8.<Return>9.<Return>10.<Return>11.<Return>12.<Return>13.<Return>14.<Return>15.<Return>16.<Return>17.<Return>18.<Esc>
  " 'O' for 'Outline'
  map <leader>I oa.<Return>b.<Return>c.<Return>d.<Return>e.<Return>f.<Return>g.<Return>h.<Return>i.<Return>j.<Return>k.<Return>l.<Return>m.<Return>n.<Return>o.<Return>p.<Return>q.<Return>r.<Return>s.<Return>t.<Return>u.<Return>v.<Return>w.<Return>x.<Return>y.<Return>z.<Esc>
  " 'I' just because it's close to 'U.'
" above is the precursor to my fancier general outline-producer.  It oughta work well enough for my current purposes
" TODO:  add a semicolon to the end of a line and Jjoin it with the next line (or in racket, just join)

" Copy things from Ubuntu 16.04 system clipboard into vim with shift+insert   (or right click + 'paste')
" map <leader>N :set nopaste<Return>   
" map <leader>p :set paste  
" TODO: reconcile <leader>p for 'paste'    with <leader>P for 'plus' in vertical resizing.
" TODO: automate the ENTIRE paste process from system clipboard; find a way to hit <Return> twice or three times or whatever, and automate the hitting of shift+insert as well.


let @s = 'A;jkJ'
let @m = 'iif __name__=="__main__":jko  '
let @f = 'ifuncname=sys._getframe().f_code.co_namejkoprint("entered function ",funcname)'
" TODO: find a way to change ':Res' to ====>  ':res'

" :set paste  " lets us paste from the Ubuntu system clipboard with proper indentation   like we would in gedit
" :set nopaste
"make if __name__=="__main__": a leader cmd rather than a macro

" TODO: python strings NOT IN PURPLE.  hard to read.

" save/recover vim screen setup in 1 (2) keystrokes: https://stackoverflow.com/questions/1416572/vi-vim-restore-opened-files
map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr>     " And load session with F3

