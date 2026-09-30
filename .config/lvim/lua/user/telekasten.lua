require('telekasten').setup {
  home = vim.fn.expand("$HOME/.notes"),
  dailies = "daily",
  extension = ".md",
  new_note_location = "home",
}

