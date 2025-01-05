lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  -- find files
  f = { "<cmd>Telescope find_files<CR>", "Find Files" },
  -- live grep
  g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
  -- view  buffers
  b = { "<cmd>Telescope buffers<CR>", "Buffers" },
  -- search neovim docs
  h = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
  -- view recent files
  r = { "<cmd>Telescope oldfiles<CR>", "Recent Files" },
}

-- find references
lvim.keys.normal_mode["<leader>rr"] = "<cmd>Telescope lsp_references<CR>"

-- find definitions
lvim.keys.normal_mode["<leader>rd"] = "<cmd>Telescope lsp_definitions<CR>"

-- find declarations
lvim.keys.normal_mode["<leader>rD"] = "<cmd>Telescope lsp_type_definitions<CR>"

-- switch from quickfix to telescope
vim.api.nvim_set_keymap("n", "<C-g>", lvim.builtin.which_key.mappings["l"]["e"][1], { noremap = true, silent = true })
