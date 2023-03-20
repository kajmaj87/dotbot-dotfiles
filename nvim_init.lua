-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information


require 'kickstart.plugins.autoformat'



-- Additional keymaps
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { desc = "Exit from editing easily" })




return {}
