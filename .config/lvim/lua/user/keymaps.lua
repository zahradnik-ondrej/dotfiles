-- vim-maximizer
lvim.keys.normal_mode["<leader>m"] = ":MaximizerToggle<CR>"

-- clear search
lvim.keys.normal_mode["<C-l>"] = ":noh<CR>"

-- horizontal window split
lvim.keys.normal_mode["<C-w>s"] = "<Nop>"
lvim.keys.normal_mode["<C-w>h"] = "<C-w>s"

-- copy entire file
lvim.keys.normal_mode["YA"] = ":<C-U>%y+<CR>"

-- delete entire file
lvim.keys.normal_mode["DA"] = ":<C-U>%d<CR>"

-- open terminal
lvim.keys.normal_mode["<leader>T"] = ":terminal<CR>"

-- enter normal mode from terminal
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- open cheat sheet in  new tab
lvim.builtin.which_key.mappings["c"] = nil
lvim.keys.normal_mode["<leader>cs"] = ":tabnew $HOME/lunarvim_cheatsheet.md<CR>"
