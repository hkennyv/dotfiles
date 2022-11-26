" use fzf w/ vim
set rtp+=/opt/homebrew/opt/fzf

call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'

imap jk <ESC>

nnoremap <S-p> :Files<Cr>
nnoremap <S-f> :Lines<Cr>
nnoremap <S-b> :Buffer<Cr>

set number
set ignorecase
set smartcase

" vscode-neovim settings
if exists('g:vscode')

else

endif

call plug#end()

" lua require ('config')

lua require'lspconfig'.pyright.setup{}
lua require'lspconfig'.rust_analyzer.setup{}
lua require'lspconfig'.gopls.setup{}

