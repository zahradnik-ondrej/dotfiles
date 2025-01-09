lvim.builtin.which_key.mappings["s"] = nil -- unbind <leader> s (Search)

lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  f = { ":Telescope find_files<CR>", "Find File" },
  r = { ":Telescope oldfiles<CR>", "View Recent Files" },
  g = { ":Telescope live_grep<CR>", "Live Grep" },
  b = { ":Telescope buffers<CR>", "View Current Buffers" },
  l = { ":Telescope resume<CR>", "Resume Last Search" },
  R = { ":Telescope lsp_references<CR>", "Find References" },
  d = { ":Telescope lsp_definitions<CR>", "Find Definitions" },
  D = { ":Telescope lsp_type_definitions<CR>", "Find Type Definitions" },
  w = { ":lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<cr>", "Grep Word Under Cursor" },
  p = { ":Telescope projects<CR>", "View All Projects" },
  m = { ":Telescope man_pages<CR>", "Search Man Pages" },
}
