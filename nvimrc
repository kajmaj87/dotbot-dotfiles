source ~/.vim/vimrc

set undofile
set undodir=~/.local/share/nvim/undo//
set backup
set backupdir=~/.local/share/nvim/backup//

nnoremap <leader>vn :e ~/.config/nvim/init.vim<CR>

call plug#begin(data_dir . '/plugins')
    Plug 'neovim/nvim-lspconfig'
call plug#end()

lua << EOF
require'lspconfig'.hls.setup{}
EOF
