version 4.0
set nocompatible
set textwidth=0
set formatoptions=tqcwn
set magic
set ignorecase
set smartcase
set autowrite
set joinspaces
set ruler
set relativenumber
set showmode
set ww=b,s,[,],<,>
set bs=2
set autoindent
set smartindent
inoremap # X#
set expandtab
set smarttab
set softtabstop=2
set splitbelow
set nostartofline
set shiftwidth=2
set history=50
set scrolloff=5
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2
" filetype off

" conditionally load up the fancy pathogen-managed stuff if it exists
" this can't use the exists() function 
if filereadable("/Users/eric/.vim/autoload/pathogen.vim")
    call pathogen#helptags()
    call pathogen#runtime_append_all_bundles()
    set background=dark
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    colorscheme solarized
    syntax on
endif

let mapleader=','
if exists(":Tabularize")
    nmap <Leader>pr :Tabularize /=><CR>
    vmap <Leader>pr :Tabularize /=><CR>
    nmap <Leader>p= :Tabularize /=<CR>
    vmap <Leader>p= :Tabularize /=<CR>
endif

autocmd BufNewFile,BufRead *.rb set fo+=a smartindent autoindent ts=2 sw=2
autocmd BufNewFile,BufRead *.md set fo+=a smartindent autoindent ts=2 sw=2

