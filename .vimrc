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

