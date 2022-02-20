" those 3 lines are needed to read vanilla vim config correctly
" https://vi.stackexchange.com/questions/12794/how-to-share-config-between-vim-and-neovim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vim/vimrc

set undofile
set undodir=~/.local/share/nvim/undo//
set backup
set backupdir=~/.local/share/nvim/backup//

nnoremap <leader>vn :e ~/.config/nvim/init.vim<CR>

source ~/.config/nvim/plugins/lsp-config.vim

call plug#begin(data_dir . '/plugins')
    source ~/.config/vim/plugins/all-vim-plugins.vim
    
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " For vsnip users.
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'


    source ~/.config/nvim/plugins/cpp.vim

call plug#end()

source ~/.config/nvim/plugins/nvim-cmp.vim
luafile ~/.config/nvim/plugins/cpp.lua

lua << EOF
require'lspconfig'.hls.setup{}
EOF

