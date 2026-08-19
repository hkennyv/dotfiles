" use fzf w/ vim
set rtp+=/opt/homebrew/opt/fzf

" plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'stevearc/conform.nvim'
Plug 'saghen/blink.cmp', {'tag': 'v0.*'}
Plug 'ellisonleao/gruvbox.nvim'

call plug#end()

" colorscheme (gruvbox) -- needs termguicolors for true 24-bit colors,
" otherwise it renders as a washed-out 256-color approximation
set termguicolors
set background=dark
lua require('gruvbox').setup({ transparent_mode = true })
colorscheme gruvbox

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
lua << EOF
-- completion (blink.cmp) capabilities get merged into every LSP config
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  completion = { documentation = { auto_show = true } },
})

-- mason: installs/manages LSP servers, linters, formatters
require('mason').setup()

-- auto-installs + auto vim.lsp.enable()'s these servers
require('mason-lspconfig').setup({
  ensure_installed = { 'pyright', 'rust_analyzer', 'gopls', 'vtsls', 'eslint' },
})

-- non-LSP CLI tools (linters/formatters) managed by mason too
require('mason-tool-installer').setup({
  ensure_installed = { 'ruff', 'prettier' },
})

-- treesitter: parser-based highlighting (fixes the regex-hang class of bug
-- that broke Vim's syntax highlighting on TSX earlier).
-- Note: nvim-treesitter's main branch is a full rewrite (Nvim 0.12+ only) --
-- no more `.configs.setup{}`; parsers install via `.install()`, and
-- highlighting/indent are enabled per-filetype via autocmds instead.
require('nvim-treesitter').install({
  'python', 'rust', 'go', 'javascript', 'typescript', 'tsx',
  'lua', 'vim', 'vimdoc',
}):wait(300000)

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'python', 'rust', 'go', 'javascript', 'javascriptreact',
    'typescript', 'typescriptreact', 'lua', 'vim',
  },
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- format on save
require('conform').setup({
  formatters_by_ft = {
    python = { 'ruff_format' },
    rust = { 'rustfmt' },
    go = { 'gofmt' },
    javascript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
})

-- LSP keymaps, attached only to buffers with an active LSP client
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
  end,
})
EOF
