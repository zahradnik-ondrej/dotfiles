lvim.colorscheme = "dracula"
lvim.builtin.bufferline.active = false
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true
lvim.transparent_window = true
lvim.builtin.terminal.active = true
vim.opt.expandtab = true

lvim.keys.normal_mode["<C-w>h"] = "<C-w>s" -- horizontal window split

lvim.keys.normal_mode["YA"] = ":<C-U>%y+<CR>"                                           -- copy entire file's content
lvim.keys.normal_mode["DA"] = ":<C-U>%d<CR>"                                            -- delete entire file's content

-- vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true }) -- cycle through windows from terminal mode
-- vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true }) -- enter normal mode from terminal window

lvim.keys.normal_mode["<C-J>"] = "ddjP"
lvim.keys.normal_mode["<C-K>"] = "ddkP"

lvim.keys.normal_mode["<C-m>"] = ":MaximizerToggle<CR>"

lvim.keys.normal_mode["<C-n>"] = ":tabnext<CR>"
lvim.keys.normal_mode["<C-p>"] = ":tabprev<CR>"

require("telescope").load_extension("vim_bookmarks")
vim.g.bookmark_sign = ""
vim.g.bookmark_annotation_sign = ""

lvim.builtin.terminal.open_mapping = "<C-t>"
lvim.builtin.terminal.directiontion = "horizontal"

vim.api.nvim_set_keymap("n", "<C-i>", "<C-o>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-o>", "<C-i>", { noremap = true, silent = true })

vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = false,
})


_G.toggle_diagnostics = function()
  local diagnostic_config_enabled = vim.g.diagnostic_config_enabled or false
  diagnostic_config_enabled = not diagnostic_config_enabled
  vim.g.diagnostic_config_enabled = diagnostic_config_enabled

  vim.diagnostic.config({
    virtual_text = diagnostic_config_enabled,
    signs = diagnostic_config_enabled,
    underline = diagnostic_config_enabled,
  })
  print("Diagnostics " .. (diagnostic_config_enabled and "enabled" or "disabled"))
end

