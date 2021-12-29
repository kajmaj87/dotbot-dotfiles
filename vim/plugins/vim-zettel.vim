" many of this was taken from: https://www.reddit.com/r/Zettelkasten/comments/fidaum/vimzettel_an_addon_for_the_vimwiki_addon_for_vim/
" this also requires fzf, but its installed separetely
Plug 'vimwiki/vimwiki'
Plug 'michal-h21/vim-zettel'

let g:vimwiki_list = [{"path":"~/org/vimbrain/", 'auto_tags': 1, 'auto_toc': 1},{"path":"~/org/vdc/", 'auto_tags': 1, 'auto_toc': 1}]

let g:vimwiki_use_mouse = 1
" let g:vimwiki_folding = 'expr'
let g:vimwiki_auto_chdir = 1
" ensure .md on all files
let g:vimwiki_markdown_link_ext = 1

let g:zettel_options = [{"front_matter" : {"tags" : ""}, "template" :  "~/.vim/plugins/vim-zettel.tpl"}, {"front_matter" : {"tags" : ""}, "template" :  "~/.vim/plugins/vim-zettel.tpl"}]

let g:zettel_format = "%y%m%d-%title"
let g:zettel_date_format = "%d.%m.%y"

let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always "


