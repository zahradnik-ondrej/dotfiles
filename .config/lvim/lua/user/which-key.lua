lvim.builtin.which_key.mappings["/"] = {
  ":lua require('Comment.api').toggle.linewise.current()<CR>", "Comment / Uncomment"
}

lvim.builtin.which_key.mappings["a"] = {
  name = "Automatic Functions",
  f = {
    function()
      lvim.format_on_save = not lvim.format_on_save
      local status = lvim.format_on_save and "enabled" or "disabled"
      print("Auto-formatting " .. status)
    end,
    "Toggle Auto-formatting"
  },
  s = { ":ASToggle<CR>", "Toggle Auto-saving" },
}

lvim.builtin.which_key.mappings["b"] = nil -- unbind <leader> b (Buffers)

lvim.builtin.which_key.mappings["c"] = nil -- unbind <leader> c (Close Buffer)
lvim.builtin.which_key.mappings["c"] = {
  name = "Custom",
  c = { ":Telescope colorscheme<CR>", "Change Colorscheme" },
  s = { ":tabnew " .. vim.fn.stdpath("config") .. "/lunarvim_cheatsheet.md<CR>", "Open LunarVim Cheatsheet" },
}

lvim.builtin.which_key.mappings["d"] = nil -- unbind <leader> d (Debug)
lvim.builtin.which_key.mappings["d"] = {
  name = "Debug",
  b = { ":lua require'dap'.step_back()<CR>", "Step Back" },
  C = { ":lua require'dap'.run_to_cursor()<CR>", "Run To Cursor" },
  c = { ":lua require'dap'.continue()<CR>", "Continue" },
  d = { ":lua require'dap'.disconnect()<CR>", "Disconnect" },
  g = { ":lua require'dap'.get_session()<CR>", "Session Info" },
  i = { ":lua require'dap'.step_into()<CR>", "Step Into" },
  o = { ":lua require'dap'.step_over()<CR>", "Step Over" },
  p = { ":lua require'dap'.pause()<CR>", "Pause" },
  q = { ":lua require'dap'.terminate()<CR>", "Quit" },
  r = { ":lua require'dap'.repl.toggle()<CR>", "Toggle REPL" },
  s = { ":lua require'dap'.continue()<CR>", "Start" },
  t = { ":lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
  U = { ":lua require'dapui'.toggle()<CR>", "Toggle UI" },
  u = { ":lua require'dap'.step_out()<CR>", "Step Out" },
}

lvim.builtin.which_key.mappings["e"] = {
  ":Neotree toggle<CR>", "Toggle File Explorer"
}

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

lvim.builtin.which_key.mappings["g"] = nil -- unbind <leader> g (Git)
lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  b = { ":Telescope git_branches<CR>", "Checkout Branch" },
  C = { ":Telescope git_bcommits<CR>", "Checkout Commit (for current file)" },
  c = { ":Telescope git_commits<CR>", "Checkout Commit" },
  d = { ":Gitsigns diffthis<CR>", "Git Diff" },
  l = { ":Gitsigns blame_line<CR>", "Blame Line" },
}

-- lvim.builtin.which_key.mappings["g"] = {
--   d = { ":DiffviewOpen<CR>", "Open Diff View" },
--   h = { ":DiffviewFileHistory<CR>", "Open Repo History" },
--   f = { ":DiffviewFileHistory %<CR>", "Open File History" },
--   q = { ":DiffviewClose<CR>", "Close Diff View" },
-- }

lvim.builtin.which_key.mappings["h"] = {
  ":nohlsearch<CR>", "Clear Highlighting"
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

lvim.builtin.which_key.mappings["m"] = {
  ":MaximizerToggle<CR>", "Maximize Window"
}

lvim.builtin.which_key.mappings["n"] = {
  name = "Notes",
  c = { ":Telekasten show_calendar<CR>", "Show Calendar" },
  n = { ":Telekasten new_note<CR>", "New Note" },
  f = { ":Telekasten find_notes<CR>", "Find Notes" },
}

lvim.builtin.which_key.mappings["p"] = {
  ":Lazy<CR>", "Plugin Manager (Lazy)"
}

lvim.builtin.which_key.mappings["q"] = {
  ":q<CR>", "Close File"
}

lvim.builtin.which_key.mappings["Q"] = {
  ":qa!<CR>", "Quit LunarVim"
}

lvim.builtin.which_key.mappings["s"] = nil -- unbind <leader> s (Search)

lvim.builtin.which_key.mappings["t"] = {
  name = "Tabs",
  t = { ":tabnew<CR>", "New Tab" },
  q = { ":tabclose<CR>", "Close Tab" },
  n = { ":tabnext<CR>", "Next Tab" },
  p = { ":tabprev<CR>", "Previous Tab" },
}

lvim.builtin.which_key.mappings["T"] = nil -- unbind <leader> T (Treesitter)
lvim.builtin.which_key.mappings["T"] = {
  ":terminal<CR>", "Open Terminal"
}

lvim.builtin.which_key.mappings["w"] = {
  ":w<CR>", "Save File"
}

