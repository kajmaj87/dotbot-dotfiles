Plug '907th/vim-auto-save'

" do not display the auto-save notification
let g:auto_save_silent = 1  

" for now enable only in wiki markdown files
let g:auto_save = 0

augroup ft_wiki
  au!
  au FileType vimwiki let b:auto_save = 1
augroup END
