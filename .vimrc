"===================================================================================================
" TODO: resolve merge conflicts (grab the best of all the vimrc versions.    
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
:map K :wa!<Return>
:map <leader>Y :xa<Return>
:map Q :qa<Return>
:map <leader>Z :bp<Return>
:map <leader>X :bn<Return>
" To exit ex mode (if you accidentally type ':i'), type just a single dot:  '.'
"   src: https://www.google.com/search?q=enter+ex+mode&oq=enter+ex+mode&aqs=chrome..69i57.1836j0j0&client=ubuntu&sourceid=chrome&ie=UTF-8


":nmap <Return> i<Return><Esc>  " this also works (':nmap')
:map <Return> i<Return><Esc>
:map <Tab> i<Tab><Esc>l
":map <Tab> EBi<Tab><Esc>l
:map <Space> i<Space><Esc>
:map <Backspace> i<Backspace><Esc>l

set number
set tabstop=4    "4 in boosted.AI's codebase; 2 is my personal preference.     
set shiftwidth=4 "4 in boosted.AI's codebase; 2 is my personal preference     
"set expandtab    " should I use tabs instead of spaces?  See: Richard Hendricks of 'Silicon Valley' fame
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

" Shortcutting split navigation, saving a keypress:
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

" kill a buffer
  map <leader>Q :q<Return>
" Shortcutting split resizing, saving a keypress:
  map <leader>P :res<Space>+1<Return>
  map <leader>M :res<Space>-1<Return>
  map <leader>L :vertical<Space>resize<Space>+1<Return>
  map <leader>R :vertical<Space>resize<Space>-1<Return>
" I used leader instead of 'ctrl' b/c <C-o> is useful
  map <leader>O o1.<Return><Space><Space>a.<Return><Backspace><Backspace>2.<Return>3.<Return>4.<Return>5.<Return>6.<Return>7.<Return>8.<Return>9.<Return>10.<Return>11.<Return>12.<Return>13.<Return>14.<Return>15.<Return>16.<Return>17.<Return>18.<Esc>
  " 'O' for 'Outline'
  map <leader>I oa.<Return>b.<Return>c.<Return>d.<Return>e.<Return>f.<Return>g.<Return>h.<Return>i.<Return>j.<Return>k.<Return>l.<Return>m.<Return>n.<Return>o.<Return>p.<Return>q.<Return>r.<Return>s.<Return>t.<Return>u.<Return>v.<Return>w.<Return>x.<Return>y.<Return>z.<Esc>
  map <leader>JJ apublic class Main {<Return> public static void main(String[] args) {<Return>}<Return>}
  " TODO:    make the comment actually mark today's date using `date` and format arguments to 

  " 'I' just because it's close to 'U.'
" above is the precursor to my fancier general outline-producer.  It oughta work well enough for my current purposes

" Copy things from Ubuntu 16.04 system clipboard into vim with shift+insert   (or right click + 'paste')

let @e = 'li<Return>jk'
let @s = 'A;jkJ'
let @m = 'iif __name__=="__main__":jko  '
let @j = 'iSystem.out.println('
let @p = 'ipublic class Main {\<Esc>o public static void main(String[] args) {'
"<Return> public static void main(String[] args) { } }'
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


set wrap
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
:map <leader>W :vertical resize1<Return>
:map <leader>G :res1<Return>
:map <leader>F :res<Return>
:map <leader>T :res<Return>:vertical resize<Return>

:map <leader>S :sp<Return>
:map <leader>D :vs<Return>
:map <leader>N :set nopaste<Return>
:map <leader>B :set paste<Return>


" Return to last edit position when opening files (You want this!)
"   More details can be found (about default cursor location) at   https://stackoverflow.com/questions/7894330/preserve-last-editing-position-in-vim
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif



" ignore case when searching
:map <leader>H :set ignorecase<Return>
:map <leader>E :set noignorecase<Return>

":map <leader>A :set nonumber<Return>
" I hardly ever use ':set number<Return>'             , does this do again?   Nevermindvm I always jus tdo it by hand.
":map <leader>K :set number<Return>
" TODO: more clipboard AKA   copy and paste ones.


" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif








" These cmds should copy to / paste from  system clipboard :  
" 1.  https://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard    
" 2.  https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
:map <Leader>y "*y
:map <Leader>p "*p
:map <Leader>d "*d

" This will get in the way of my mapping UY => :xa
" :map <Leader>Y "+y
" This will get in the way of my mapping UD => :vs<Return>
":map <Leader>D "*d
" This will get in the way of my mapping UP;    (<leader>P :res<Space>+1<Return>)
":map <Leader>P "+p
"  It's probably better to just remember how to use the registers.  -nxb, June 16, 2020



:map <leader>W :w!<Return>
:map <leader>E :ls<Return>
:map <leader>K :pwd<Return>   
" Cross reference with macbook if this starts confusing your fingers .                              
 
":map <leader>W :pwd!<Return>

" Use the rest of the keymappings and find free available keys to pair with   leader (<leader>)    that give us even more power             from  my macbook's .               




















































"==================================================================================================                      
"==================================================================================================                      
"==================================================================================================                      
"==================================================================================================                      
"==================================================================================================                      
" Start of Capital One's Vimrc:                                                                                        
"   Hopefully there isn't too much weirdness from having most commands twice.                                               
"==================================================================================================                           
"==================================================================================================                      
"==================================================================================================                      
"==================================================================================================                      
"==================================================================================================                      


"        _  
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

" http://vimdoc.sourceforge.net/htmldoc/starting.html#vimrc

"==================================================================================================
" TODO: use non-alphabetical & non-numerical keys for extra mappings     in stead    
" ie. pipe, backslash (\), equal (=), plus (+),         &, etc.      etc.                  

let mapleader="U"
"==================================================================================================


" escape keys' mappings                  
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

" last tab, just like it would do in chrome                  
":map 0gt 1gtgT        
":map 9gt 1gtgT
"    using 0 doesn't allow down a command I use as often, so I remapped this to '8gt' instead of .        
:map 8gt 1gtgT
" '8gT' is the new tab version    (approx equal to 'ctrl+t' new tab command from Google Chrome)            
:map 8gT 1gtgT:tabnew<Return>
:cmap TE tabe                              
:cmap TAN tabnew                          
" i map it this way so it's more flexible for     vertical resize+ AND     vertical resize-
:cmap VR vertical resize


" Save and/or quit different types of files:
:map K :wa!<Return>
:map <leader>Y :xa!<Return>
:map Q :qa!<Return>
:map <leader>Z :bp<Return>
:map <leader>X :bn<Return>
" To exit ex mode (if you accidentally type ':i'), type just a single dot:  '.'
"   src: https://www.google.com/search?q=enter+ex+mode&oq=enter+ex+mode&aqs=chrome..69i57.1836j0j0&client=ubuntu&sourceid=chrome&ie=UTF-8


":nmap <Return> i<Return><Esc>  " this also works (':nmap')
:map <Return> i<Return><Esc>
:map <Tab> i<Tab><Esc>l
":map <Tab> EBi<Tab><Esc>l
:map <Space> i<Space><Esc>
:map <Backspace> i<Backspace><Esc>l

" NOTE:     detailed                  
"   tabs vs spaces:      https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces                  
set tabstop=4 "2    "8
set shiftwidth=2 "4
set expandtab     " just for boosted.AI
"set expandtab    " should I use tabs instead of spaces?  No.  Tabs make more sense.     
"set noexpandtab
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
  map <leader>JO o1)<Return><Space><Space>a)<Return><Backspace><Backspace>2)<Return>3)<Return>4)<Return>5)<Return>6)<Return>7)<Return>8)<Return>9)<Return>10)<Return>11)<Return>12)<Return>13)<Return>14)<Return>15)<Return>16)<Return>17)<Return>18)<Esc>
  " 'O' for 'Outline'
  map <leader>I oa.<Return>b.<Return>c.<Return>d.<Return>e.<Return>f.<Return>g.<Return>h.<Return>i.<Return>j.<Return>k.<Return>l.<Return>m.<Return>n.<Return>o.<Return>p.<Return>q.<Return>r.<Return>s.<Return>t.<Return>u.<Return>v.<Return>w.<Return>x.<Return>y.<Return>z.<Esc>
  map <leader>JI oa)<Return>b)<Return>c)<Return>d)<Return>e)<Return>f)<Return>g)<Return>h)<Return>i)<Return>j)<Return>k)<Return>l)<Return>m)<Return>n)<Return>o)<Return>p)<Return>q)<Return>r)<Return>s)<Return>t)<Return>u)<Return>v)<Return>w)<Return>x)<Return>y)<Return>z)<Esc>
  " I use 'I' just because it's close to 'U.'

" above is the precursor to my fancier general outline-producer.  It oughta work well enough for my current purposes

" Copy things from Ubuntu 16.04 system clipboard into vim with shift+insert   (or right click + 'paste')


let @s = 'A;jkJ'
let @m = 'iif __name__=="__main__":jko  '
let @i = 'i    def __init__(self):jko'             " class definition                
let @f = 'ifuncname=sys._getframe().f_code.co_namejkoprint("entered function ",funcname)'
let @d = '$ge9lDj$'
let @S = '$9A j$'
" Both the following macros are for quickly (in few keystrokes)   removing the weird spacing I do a lot:                
let @b = 'gE2ldWB' "   'b' stands for 'backwards (delete)' here    
let @D = 'WgE2ldWE' "   'D' stands for 'delete (forward)' here    

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


set number
set scrolloff=1         " keep 1 lines when scrolling
"set scrolloff=5         " keep 5 lines when scrolling
" TODO:  bp    (prev buffer)
" TODO: python strings NOT IN PURPLE.  hard to read.
set showcmd
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching

set fileformat=unix " always causes issues when I push to Jenkins at CapitalOne.                  
set mouse=a " can click with mouse to move cursor.  Hopefully supports highlighting too, like in GVim on Windows.  We will see shortly. :)      Feb 11, 2024                          


"set visualbell t_vb=    " turn off error beep/flash
"set novisualbell        " turn off visual bell

syntax on               " turn syntax highlighting on by default
filetype on             " detect type of file






" highlighting:
:syntax on " highlighting

":map <leader>V :tabnew<Return>                  


:map <leader>V :vertical resize<Return>
:map <leader>G :res1<Return>
:map <leader>F :res<Return>
:map <leader>T :res<Return>:vertical resize<Return>
:map <leader>S :sp<Return>
:map <leader>D :vs<Return>
:map <leader>N :set nopaste<Return>
:map <leader>B :set paste<Return>
":map <leader>I :bp<Return>
":map <leader>O :bn<Return>
" I and O are right next to each other.  after

:map <leader>\| :set ignorecase<Return>
:map <leader>+ :set noignorecase<Return>

" These cmds should copy to / paste from  system clipboard :  
" 1.  https://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard    
" 2.  https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
:map <Leader>y "*y
:map <Leader>p "*p
:map <Leader>d "*d

" This will get in the way of my mapping UY => :xa
" :map <Leader>Y "+y
" This will get in the way of my mapping UD => :vs<Return>
":map <Leader>D "*d
" This will get in the way of my mapping UP;    (<leader>P :res<Space>+1<Return>)
":map <Leader>P "+p
"  It's probably better to just remember how to use the registers.  -nxb, June 16, 2020

:map <Leader>W :w!<Return>
:map <Leader>E :ls<Return>
:map <Leader>K :!pwd<Return>
:map <Leader>J :pwd<Return>
":map <Leader><Comma> :pwd<Return>    doesn't save us THAT much time
" :map <Leader>J :!pwd<Return>   Available:   J, H, A, C, <comma>, <period>              

" Insert and/ or       comment here.

" Spell checking.  ( https://neovim.io/doc/user/spell.html )                        
:setlocal spell spelllang=en_us









"" Create a directory for session files if it doesn't exist
"let g:session_dir = $HOME . '/.vim/sessions'
"
"" Automatically saves a session with a timestamp
"function! SaveSessionHourly(timer_id)
"    " Don't try to save while Vim is exiting
"    if v:dying
"        return
"    endif
"    
"    " Check and create the session directory
"    if !isdirectory(g:session_dir)
"        call mkdir(g:session_dir, 'p')
"    endif
"    
"    " Create a timestamped session filename
"    let l:timestamp = strftime("%Y-%m-%d__%H-%M-%S")
"    let l:session_file = g:session_dir . '/' . l:timestamp . '.vim'
"    
"    " Save the session
"    execute 'mksession! ' . l:session_file
"    echom "Hourly session saved to " . l:session_file
"endfunction
"
"" Start the timer on Vim startup to run the function every hour
"augroup HourlySessionSaver
"    autocmd!
"    autocmd VimEnter * call timer_start(1000 * 60 * 60, function('SaveSessionHourly'), {'repeat': -1})
"augroup END

"   vimrc automatically create vim session with timestamp every hour
"   You can automatically create a timestamped Vim session every hour by adding a function and an autocommand to your .vimrc file. This setup uses Vim's built-in timer functionality. 
"
"
"
"
"
" + random noise:

" --- Configuration ---
" Create a directory for session files if it doesn't exist
let g:session_dir = $HOME . '/.vim/sessions'


" --- Session Save Function ---
" Automatically saves a session with a timestamp
function! SaveSessionHourly(timer_id)
    " Don't try to save while Vim is exiting
    if v:dying
        return
    endif
    
    " Check and create the session directory
    if !isdirectory(g:session_dir)
        call mkdir(g:session_dir, 'p')
    endif
    
    " Create a timestamped session filename (includes seconds to be safe)
    let l:timestamp = strftime("%Y-%m-%d__%H-%M-%S")
    let l:session_file = g:session_dir . '/' . l:timestamp . '.vim'
    
    " Save the session
    execute 'mksession! ' . l:session_file
    echom "Hourly session saved to " . l:session_file
endfunction


" --- Timer Starter Functions ---
" This function is called once after the initial random delay.
" It performs the first save and then starts the repeating hourly timer.
function! s:StartSaveCycle(timer_id)
    " 1. Perform the first save immediately.
    call SaveSessionHourly(0)

    " 2. Start the repeating timer for all subsequent hourly saves.
    call timer_start(1000 * 60 * 60, 'SaveSessionHourly', {'repeat': -1})
endfunction

" This function sets up the initial randomized timer.
function! s:SetupRandomTimer()
    " Seed the random number generator for better randomness across instances.
    call srand(reltime()[0])

    " Calculate a random delay between 0 and 29999 milliseconds (0-29 seconds).
    let l:random_delay_ms = rand() % 30000

    " Start a one-time timer that will kick off the main save cycle.
    call timer_start(l:random_delay_ms, 's:StartSaveCycle')
endfunction


" --- Autocommand on Vim Startup ---
augroup HourlySessionSaver
    autocmd!
    " When Vim starts, call the setup function to begin the randomized timer.
    autocmd VimEnter * call s:SetupRandomTimer()
augroup END








" This line is because:                                                                                    
"   Boosted.AI uses spaces instead of tabs.  **__I__** personally like tabs better, but whatever.              
ret

" Generate ctags for easier searching:              
"  Sources:https://stackoverflow.com/questions/155449/vim-auto-generate-ctags?rq=3
"           https://stackoverflow.com/questions/635770/jump-to-function-definition   
"au BufWritePost *.py,*.sh silent! !ctags -R   --exclude="/Users/n/Documents/code/agent-service-code/agent-service/.venv" --exclude=.git --exclude=node_modules   &          " this is good for showing you the errors,  but it automatically spams everything in the shell, (including  through Vim)  when I do it this way    .             
autocmd BufWritePost *.py,*.sh,*.js silent! !/usr/bin/ctags -R --exclude=/Users/n/Documents/code/agent-service-code/agent-service/.venv --exclude=.git --exclude=node_modules  2> /dev/null &

"   ^ This wasn't working, and I have actual work to finish instead of this.                      
" TO FIX ERRORS, JUST REDO IT MANUALLY;    just run `ctags -R .` to regenerate the tags in the root directory                        
" TO FIX ERRORS, JUST REDO IT MANUALLY;    just run `ctags -R .` to regenerate the tags in the root directory                        
" TO FIX ERRORS, JUST REDO IT MANUALLY;    just run `ctags -R .` to regenerate the tags in the root directory                        
" TO FIX ERRORS, JUST REDO IT MANUALLY;    just run `ctags -R .` to regenerate the tags in the root directory                        





#   NOTE:   PUSH TO your personal (neonb88) GitHub.                     
:tags /Users/n/Documents/code/agent-service-code/agent-service/tags










