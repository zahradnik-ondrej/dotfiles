
-- new tab
lvim.keys.normal_mode["<leader>t"] = ":tabnew<CR>"

-- close tab
lvim.keys.normal_mode["<leader>q"] = ":tabclose<CR>"

-- next tab
vim.api.nvim_set_keymap('n', '<C-n>', ':tabnext<CR>', { noremap = true, silent = true })

-- previous tab
vim.api.nvim_set_keymap('n', '<C-p>', ':tabprev<CR>', { noremap = true, silent = true })
