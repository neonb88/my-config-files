"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|

let mapleader="U"
map <leader>O o1.<Return>2.<Return>3.<Return>4.<Return>5.<Return>6.<Return>7.<Esc>
" above is the precursor to my fancier general outline-producer.  It oughta work well enough for my current purposes

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

:map <Return> i<Return><Esc>
:map <Tab> i<Tab><Esc>l
":map <Tab> EBi<Tab><Esc>l
:map <Space> i<Space><Esc>
:map <Backspace> i<Backspace><Esc>l

set tabstop=2    "4
set shiftwidth=2 "4
set expandtab    " should I use tabs instead of spaces?
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

