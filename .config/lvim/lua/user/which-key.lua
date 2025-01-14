local wk = lvim.builtin.which_key

wk.mappings["/"] = {
  ":lua require('Comment.api').toggle.linewise.current()<CR>", "Comment / Uncomment"
}

wk.mappings["a"] = {
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

wk.mappings["b"] = nil -- unbind <leader> b (Buffers)
wk.mappings["b"] = {
   name = "Bookmarks",
   b = { ":BookmarkToggle<CR>", "Toggle Bookmark" },
   n = { ":BookmarkNext<CR>", "Next Bookmark" },
   p = { ":BookmarkPrev<CR>", "Previous Bookmark" },
   a = { ":BookmarkAnnotate<CR>", "Annotate Bookmark" },
   l = { ":Telescope vim_bookmarks all<CR>", "List All Bookmarks" },
   f = { ":Telescope vim_bookmarks current_file<CR>", "File Bookmarks" },
}

wk.mappings["c"] = nil -- unbind <leader> c (Close Buffer)
wk.mappings["c"] = {
  name = "Custom",
  c = { ":Telescope colorscheme<CR>", "Change Colorscheme" },
  s = { ":tabnew " .. vim.fn.stdpath("config") .. "/lunarvim_cheatsheet.md<CR>", "Open LunarVim Cheatsheet" },
}

wk.mappings["d"] = nil -- unbind <leader> d (Debug)
wk.mappings["d"] = {
  name = "Debug",
  b = { ":lua require'dap'.step_back()<CR>", "Step Back" },
  C = { ":lua require'dap'.run_to_cursor()<CR>", "Run To Cursor" },
  c = { ":lua require'dap'.continue()<CR>", "Continue" },
  d = { ":Trouble diagnostics toggle<CR>", "Toggle Diagnostics" },
  D = { ":lua require'dap'.disconnect()<CR>", "Disconnect" },
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

wk.mappings["e"] = {
  ":Neotree toggle<CR>", "Toggle File Explorer"
}

wk.mappings["f"] = {
  name = "Find",
  f = { ":Telescope find_files<CR>", "Find File" },
  r = { ":Telescope oldfiles<CR>", "View Recent Files" },
  g = { ":Telescope live_grep<CR>", "Live Grep" },
  b = { ":Telescope buffers<CR>", "View Current Buffers" },
  l = { ":Telescope resume<CR>", "Resume Last Search" },
  R = { ":Telescope lsp_references<CR>", "Find References" },
  d = { ":Telescope lsp_definitions<CR>", "Find Definitions" },
  D = { ":Telescope lsp_type_definitions<CR>", "Find Type Definitions" },
  w = { ":lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>", "Grep Word Under Cursor" },
  p = { ":Telescope projects<CR>", "View All Projects" },
  m = { ":Telescope man_pages<CR>", "Search Man Pages" },
}

wk.mappings["g"] = nil -- unbind <leader> g (Git)
wk.mappings["g"] = {
  name = "Git",
  b = { ":Telescope git_branches<CR>", "Checkout Branch" },
  C = { ":Telescope git_bcommits<CR>", "Checkout Commit (for current file)" },
  c = { ":Telescope git_commits<CR>", "Checkout Commit" },
  d = { ":DiffviewOpen<CR>", "Open Diff View" },
  -- d = { ":Gitsigns diffthis<CR>", "Git Diff" },
  f = { ":DiffviewFileHistory %<CR>", "Open File History" },
  l = { ":Gitsigns blame_line<CR>", "Blame Line" },
  r = { ":DiffviewFileHistory<CR>", "Open Repo History" },
  q = { ":DiffviewClose<CR>", "Close Diff View" },
  L = { ":LazyGit<CR>", "Lazygit" },
}

wk.mappings["h"] = {
  ":nohlsearch<CR>", "Clear Highlighting"
}

wk.mappings["l"] = nil -- unbind <leader> l (LSP)
wk.mappings["l"] = {
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

wk.mappings["L"] = nil -- unbind <leader> L (LunarVim)
wk.mappings["L"] = {
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

wk.mappings["m"] = {
  ":MaximizerToggle<CR>", "Maximize Window"
}

wk.mappings["n"] = {
  name = "Notes",
  c = { ":Telekasten show_calendar<CR>", "Show Calendar" },
  n = { ":Telekasten new_note<CR>", "New Note" },
  f = { ":Telekasten find_notes<CR>", "Find Notes" },
}

wk.mappings["o"] = {
  ":enew<CR>", "Open New File"
}

wk.mappings["p"] = {
  ":Lazy<CR>", "Plugin Manager (Lazy)"
}

wk.mappings["q"] = {
  ":q<CR>", "Close File"
}

wk.mappings["Q"] = {
  ":qa!<CR>", "Quit LunarVim"
}

wk.mappings["s"] = nil -- unbind <leader> s (Search)
wk.mappings["s"] = {
  name = "Session",
  l = { ":lua require('persistence').load()<CR>", "Load Session" },
  L = { ":lua require('persistence').load({ last = true })<CR>", "Load Last Session" },
  s = { ":lua require('persistence').select()<CR>", "Select Session" }
}

wk.mappings["t"] = {
  name = "Tabs",
  t = { ":tabnew<CR>", "New Tab" },
  q = { ":tabclose<CR>", "Close Tab" },
  n = { ":tabnext<CR>", "Next Tab" },
  p = { ":tabprev<CR>", "Previous Tab" },
}

wk.mappings["T"] = nil -- unbind <leader> T (Treesitter)
-- wk.mappings["T"] = {
--   ":terminal<CR>", "Open Terminal"
-- }

wk.mappings["w"] = {
  ":w<CR>", "Save File"
}

