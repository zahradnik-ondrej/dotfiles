require('telekasten').setup {
  home = vim.fn.expand("$HOME/.notes"),
  dailies = "daily",
  extension = ".md",
  new_note_location = "home",
}

lvim.builtin.which_key.mappings["n"] = {
  name = "Notes",
  c = { ":Telekasten show_calendar<CR>", "Show Calendar" },
  n = { ":Telekasten new_note<CR>", "New Note" },
  f = { ":Telekasten find_notes<CR>", "Find Notes" },
}
