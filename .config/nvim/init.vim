" use fzf w/ vim
set rtp+=/opt/homebrew/opt/fzf

" plugins
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'

call plug#end()

" use ripgrep if available
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" better esc
imap jk <ESC>

" fzf hotkeys
nnoremap <S-p> :Files<Cr>
nnoremap <S-f> :Lines<Cr>
nnoremap <S-b> :Buffer<Cr>

" spaces & tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set copyindent

" ui config
set hidden
set number
set cursorline
set wildmenu
set showmatch
set signcolumn=yes

" search
set hlsearch
set ignorecase
set smartcase

" vscode-neovim settings
if exists('g:vscode')

else

endif

" lua config
lua require'lspconfig'.pyright.setup{}
lua require'lspconfig'.rust_analyzer.setup{}
lua require'lspconfig'.gopls.setup{}

