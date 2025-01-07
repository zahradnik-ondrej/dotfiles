lvim.colorscheme = "dracula"
lvim.builtin.bufferline.active = false
vim.opt.relativenumber = true -- relative line numbers
lvim.transparent_window = false
lvim.format_on_save.enabled = true

lvim.builtin.which_key.mappings["Q"] = { "<cmd>qa<CR>", "Quit LunarVim" }
lvim.builtin.which_key.mappings["cs"] = { ":tabnew $HOME/lunarvim_cheatsheet.md<CR>", "Open LunarVim Cheatsheet" }
lvim.builtin.which_key.mappings["h"] = { lvim.builtin.which_key.mappings["h"][1], "Clear Highlighting" }
lvim.keys.normal_mode = { ["<C-w>s"] = "<Nop>", ["<C-w>h"] = "<C-w>s" } -- horizontal window split
lvim.builtin.which_key.mappings["e"] = { lvim.builtin.which_key.mappings["e"][1], "Toggle File Explorer" }
lvim.builtin.which_key.mappings["/"] = { lvim.builtin.which_key.mappings["/"][1], "Comment / Uncomment" }
lvim.keys.normal_mode["YA"] = ":<C-U>%y+<CR>"                                           -- copy entire file's content
lvim.keys.normal_mode["DA"] = ":<C-U>%d<CR>"                                            -- delete entire file's content
lvim.builtin.which_key.mappings["T"] = { ":terminal<CR>", "Open Terminal" }
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true }) -- enter normal mode from terminal window

lvim.builtin.which_key.mappings["t"] = {
  name = "Tabs",
  t = { ":tabnew<CR>", "New Tab" },
  q = { ":tabclose<CR>", "Close Tab" },
  n = { ":tabnext<CR>", "Next Tab" },
  p = { ":tabprev<CR>", "Previous Tab" },
}

lvim.keys.normal_mode["<C-n>"] = ":tabnext<CR>"
lvim.keys.normal_mode["<C-p>"] = ":tabprev<CR>"
