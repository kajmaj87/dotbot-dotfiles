source ~/.vim/vimrc

set undofile
set undodir=~/.local/share/nvim/undo//
set backup
set backupdir=~/.local/share/nvim/backup//

nnoremap <leader>vn :e ~/.config/nvim/init.vim<CR>

source ~/.config/nvim/plugins/lsp-config.vim

call plug#begin(data_dir . '/plugins')
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " For vsnip users.
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    " For luasnip users.
    " Plug 'L3MON4D3/LuaSnip'
    " Plug 'saadparwaiz1/cmp_luasnip'

    " For ultisnips users.
    " Plug 'SirVer/ultisnips'
    " Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    " For snippy users.
    " Plug 'dcampos/nvim-snippy'
    " Plug 'dcampos/cmp-snippy'
call plug#end()

source ~/.config/nvim/plugins/nvim-cmp.vim

lua << EOF
require'lspconfig'.hls.setup{}
EOF
