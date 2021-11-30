Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" find Files
nnoremap <silent> <leader>ff :Files<CR>
" find Inside files
nnoremap <silent> <leader>fi :Rg<CR>
" find Buffers
nnoremap <silent> <leader>fb :Buffers<CR> 
" find in Git commits
nnoremap <silent> <leader>fg :Commits<CR> 
" find in Open buffers
nnoremap <silent> <leader>fo :Lines<CR> 
" find in vim History of files
nnoremap <silent> <leader>fh :History<CR> 
