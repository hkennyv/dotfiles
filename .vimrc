" specify dir for plugins
call plug#begin('~/.vim/plugged')

" fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'tpope/vim-sensible'
Plug 'romainl/vim-cool'
Plug 'w0rp/ale'

"
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" language specific plugins
Plug 'rust-lang/rust.vim'
Plug 'psf/black'
Plug 'prettier/vim-prettier', { 'do' : 'yarn install' }

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'kadekillary/Turtles'
Plug 'arzg/vim-colors-xcode'

" initialize plugin system
call plug#end()

" linters
let g:ale_sign_column_always = 1
let g:ale_linters = {
\  'c': ['gcc', 'clang'],
\  'javascript': ['eslint'],
\  'python': ['pylint', 'flake8']
\}

" vim-cool settings
let g:CoolTotalMatches = 1

" theme settings
set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=none

" syntax/editor settings
syntax on
set number
set list
set tabstop=4
set expandtab
set shiftwidth=4
set shiftround

" search options
set hlsearch
set ignorecase
set incsearch
set smartcase

set colorcolumn=80 textwidth=79

" key mappings
imap jk <Esc>

" nerdtree
map <silent> <C-n> :NERDTreeToggle<CR>

" nerdcommenter - toggle with ctrl + /
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle

let g:NERDSpaceDelims = 1           " space after comment
let g:NERDCompactSexyComs = 1       " prettified multi-line comments
let g:NERDDefaultAlign = 'left'     " left flush comments
let g:NERDCommentEmptyLines = 1     " comment empty lines

" fzf key mappings
nnoremap <C-p> :Files<Cr>
nnoremap <S-f> :Rg<Cr>

" coc.nvim settings
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

