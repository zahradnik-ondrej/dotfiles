lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  f = { "<cmd>Telescope find_files<CR>", "Find Files" },
  r = { "<cmd>Telescope oldfiles<CR>", "View Recent Files" },
  g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
  b = { "<cmd>Telescope buffers<CR>", "View Current Buffers" },
  h = { "<cmd>Telescope help_tags<CR>", "Search Neovim Docs" },
  l = { "<cmd>Telescope resume<CR>", "Resume Last Search" },
  R = { "<cmd>Telescope lsp_references<CR>", "Find References" },
  d = { "<cmd>Telescope lsp_definitions<CR>", "Find Definitions" },
  D = { "<cmd>Telescope lsp_type_definitions<CR>", "Find Type Definitions" },
  w = { "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<cr>", "Grep Word Under Cursor" },
  p = { "<cmd>Telescope projects<CR>", "View All Projects" },
}

lvim.keys.normal_mode["<C-g>"] = lvim.builtin.which_key.mappings["l"]["e"][1] -- switch from quickfix to telescope
