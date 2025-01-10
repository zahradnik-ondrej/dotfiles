require("hop").setup({
  keys = "etovxqpdygfblzhckisuran",
})

lvim.builtin.which_key.mappings["j"] = {
  name = "Jump",
  w = { ":HopWordMW<CR>", "Jump to Word" },
  c = { ":HopChar1<CR>", "Jump to Char" },
  l = { ":HopLine<CR>", "Jump to Line" },
  v = { ":HopVertical<CR>", "Jump Vertically" },
  a = { ":HopAnywhere<CR>", "Jump Anywhere" },
  r = { ":HopPattern<CR>", "Jump to Regex" },
}
