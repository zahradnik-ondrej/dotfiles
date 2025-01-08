require("hop").setup({
  keys = "etovxqpdygfblzhckisuran",
})

lvim.builtin.which_key.mappings["j"] = {
  name = "Jump",
  w = { "<cmd>HopWordMW<CR>", "Jump to Word" },
  c = { "<cmd>HopChar1<CR>", "Jump to Char" },
  l = { "<cmd>HopLine<CR>", "Jump to Line" },
  v = { "<cmd>HopVertical<CR>", "Jump Vertically" },
  a = { "<cmd>HopAnywhere<CR>", "Jump Anywhere" },
  r = { "<cmd>HopPattern<CR>", "Jump to Regex" },
}
