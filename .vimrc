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
set number
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
set laststatus=2
" this no longer seems to work and i can't be arsed to fix it
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" filetype off

" conditionally load up the fancy pathogen-managed stuff if it exists
" this can't use the exists() function 
if filereadable("/home/eric/.vim/autoload/pathogen.vim")
    call pathogen#helptags()
    call pathogen#infect()
    set background=light
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

function! ToggleNumber()
  if (&number)
    set relativenumber
    set nonumber
  else
    set norelativenumber
    set number
  endif
endfunction

nmap <Leader>n :call ToggleNumber()<CR>

autocmd BufNewFile,BufRead *.rb set fo+=a smartindent autoindent ts=2 sw=2
autocmd BufNewFile,BufRead *.md set fo+=a smartindent autoindent ts=2 sw=2 tw=120
autocmd BufNewFile,BufRead pico.* set fo+=a tw=78
