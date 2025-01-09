lvim.colorscheme = "dracula"
lvim.builtin.bufferline.active = false
vim.opt.relativenumber = true -- relative line numbers
lvim.transparent_window = false

lvim.builtin.alpha.dashboard.section.footer.val = ""

lvim.builtin.which_key.mappings["h"] = { lvim.builtin.which_key.mappings["h"][1], "Clear Highlighting" }

lvim.keys.normal_mode["<C-w>h"] = "<C-w>s" -- horizontal window split

lvim.builtin.which_key.mappings["/"] = { lvim.builtin.which_key.mappings["/"][1], "Comment / Uncomment" }

lvim.keys.normal_mode["YA"] = ":<C-U>%y+<CR>"                                           -- copy entire file's content
lvim.keys.normal_mode["DA"] = ":<C-U>%d<CR>"                                            -- delete entire file's content

lvim.builtin.which_key.mappings["T"] = nil                                              -- unbind <leader> T (Treesitter)
lvim.builtin.which_key.mappings["T"] = { ":terminal<CR>", "Open Terminal" }
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true }) -- enter normal mode from terminal window

lvim.builtin.which_key.mappings["t"] = {
  name = "Tabs",
  t = { ":tabnew<CR>", "New Tab" },
  q = { ":tabclose<CR>", "Close Tab" },
  n = { ":tabnext<CR>", "Next Tab" },
  p = { ":tabprev<CR>", "Previous Tab" },
}

lvim.builtin.which_key.mappings["l"] = nil -- unbind <leader> l (LSP)
lvim.builtin.which_key.mappings["l"] = {
  name = "LSP",
  r = { ":lua vim.lsp.buf.rename()<CR>", "Global Rename" },
  a = { ":lua vim.lsp.buf.code_action()<CR>", "Suggested Actions" },
  d = { ":Telescope diagnostics bufnr=0<CR>", "Diagnostics (Document)" },
  q = { ":lua vim.diagnostic.setloclist()<CR>", "Diagnostics (Quickfix)" },
  t = { ":Telescope diagnostics<CR>", "Diagnostics (Telescope)" },
  i = { ":LspInfo<CR>", "Info" },
  I = { ":Mason<CR>", "Mason Info" },
  S = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Dynamic Workspace Symbols" },
  s = { ":Telescope lsp_document_symbols<CR>", "Document Symbols" },
}

lvim.builtin.which_key.mappings["L"] = nil -- unbind <leader> L (LunarVim)
lvim.builtin.which_key.mappings["L"] = {
  name = "LunarVim",
  s = { ":Telescope find_files cwd=~/.config/lvim<CR>", "Search LunarVim files" },
  g = { ":Telescope live_grep cwd=~/.config/lvim<CR>", "Grep LunarVim files" },
  i = { ":LvimInfo<CR>", "View LunarVim Info" },
  C = { ":edit ~/.local/share/lunarvim/changelog.md<CR>", "View LunarVim's changelog" },
  u = { ":LvimUpdate<CR>", "Update LunarVim" },
  h = { ":Telescope help_tags<CR>", "Search Neovim Docs" },
  k = { ":Telescope keymaps<CR>", "Search Keymaps" },
  c = { ":Telescope commands<CR>", "Search Commands" },
  H = { ":Telescope highlights<CR>", "Search Highlights" },
  x = { ":Telescope registers<CR>", "Search Registers" },
  l = {
    name = "Logs",
    d = { ":view ~/.cache/lvim/log/default.log<CR>", "View LunarVim logs" },
    D = { ":edit ~/.cache/lvim/log/default.log<CR>", "Open LunarVim logfile" },
    l = { ":view ~/.cache/lvim/log/lsp.log<CR>", "View LSP logs" },
    L = { ":edit ~/.cache/lvim/log/lsp.log<CR>", "Open LSP logfile" },
    n = { ":view ~/.cache/nvim/log<CR>", "View Neovim logs" },
    N = { ":edit ~/.cache/nvim/log<CR>", "Open Neovim logfile" },
  },
}

lvim.builtin.which_key.mappings["p"] = { ":Lazy<CR>", "Plugin Manager (Lazy)" }

lvim.builtin.which_key.mappings["c"] = nil -- unbind <leader> c (Close Buffer)
lvim.builtin.which_key.mappings["c"] = {
  name = "Custom",
  c = { ":Telescope colorscheme<CR>", "Change Colorscheme" },
  s = { ":tabnew $HOME/lunarvim_cheatsheet.md<CR>", "Open LunarVim Cheatsheet" },
}

lvim.keys.normal_mode["<C-n>"] = ":tabnext<CR>"
lvim.keys.normal_mode["<C-p>"] = ":tabprev<CR>"

lvim.builtin.which_key.mappings["Q"] = { ":qa!<CR>", "Quit LunarVim" }

lvim.builtin.which_key.mappings["q"] = { ":q<CR>", "Close File" }
lvim.builtin.which_key.mappings["w"] = { ":w<CR>", "Save File" }

lvim.builtin.which_key.mappings["a"] = {
  name = "Automatic Functions",
  f = {
    function()
      lvim.format_on_save = not lvim.format_on_save
      local status = lvim.format_on_save and "enabled" or "disabled"
      print("Auto-formatting " .. status)
    end,
    "Toggle Auto-formatting",
  },
  s = {
    ":ASToggle<CR>",
    "Toggle Auto-saving",
  },
}

lvim.builtin.which_key.mappings["b"] = nil -- unbind <leader> b (Buffers)
