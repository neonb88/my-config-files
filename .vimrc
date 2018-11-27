
:imap jk <Esc>
:imap jK <Esc>
:imap Jk <Esc>
:imap JK <Esc>

:imap kj <Esc>
:imap kJ <Esc>
:imap Kj <Esc>
:imap KJ <Esc>

:map <Return> i<Return><Esc>
:map <Tab> i<Tab><Esc>l
":map <Tab> EBi<Tab><Esc>l
:map <Space> i<Space><Esc>
:map <Backspace> i<Backspace><Esc>l

set tabstop=2 "4
set shiftwidth=2 "4
set expandtab
set autoindent

autocmd FileType make setlocal noexpandtab
set backupdir^=~/.backup

:command WQ wq
:command Wq wq
:command Q q
:command U u
:command W w

