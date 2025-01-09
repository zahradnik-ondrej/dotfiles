lvim.builtin.which_key.mappings["g"] = nil -- unbind <leader> g (Git)

lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  b = { ":Telescope git_branches<CR>", "Checkout Branch" },
  C = { ":Telescope git_bcommits<CR>", "Checkout Commit (for current file)" },
  c = { ":Telescope git_commits<CR>", "Checkout Commit" },
  d = { ":Gitsigns diffthis<CR>", "Git Diff" },
  l = { ":Gitsigns blame_line<CR>", "Blame Line" },
}
