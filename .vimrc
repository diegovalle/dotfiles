" syntax on
" filetype indent plugin on
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set softtabstop=4       " number of spaces in tab when editing
set tabstop=4           " number of visual spaces per TAB
set expandtab           " tabs are spaces
" Use visual bell instead of beeping when doing something wrong
set visualbell
set spelllang=en        " spell English words
" Spellcheck for git commit messages
autocmd FileType gitcommit setlocal spell
