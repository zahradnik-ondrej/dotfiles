lvim.colorscheme = "dracula"
lvim.builtin.bufferline.active = false
vim.opt.relativenumber = true -- relative line numbers
lvim.transparent_window = true
lvim.builtin.terminal.active = true

lvim.keys.normal_mode["<C-w>h"] = "<C-w>s" -- horizontal window split

lvim.keys.normal_mode["YA"] = ":<C-U>%y+<CR>"                                           -- copy entire file's content
lvim.keys.normal_mode["DA"] = ":<C-U>%d<CR>"                                            -- delete entire file's content

-- vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true }) -- cycle through windows from terminal mode
-- vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true }) -- enter normal mode from terminal window

lvim.keys.normal_mode["<C-m>"] = ":MaximizerToggle<CR>"

lvim.keys.normal_mode["<C-n>"] = ":tabnext<CR>"
lvim.keys.normal_mode["<C-p>"] = ":tabprev<CR>"

require("telescope").load_extension("vim_bookmarks")
vim.g.bookmark_sign = ""
vim.g.bookmark_annotation_sign = ""

lvim.builtin.terminal.open_mapping = "<C-t>"
lvim.builtin.terminal.direction = "horizontal"
