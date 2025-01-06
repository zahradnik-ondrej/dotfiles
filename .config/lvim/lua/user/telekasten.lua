require('telekasten').setup {
  home = vim.fn.expand("$HOME/.notes"),
  dailies = "daily",
  extension = ".md",
}

-- show calendar
lvim.keys.normal_mode['<leader>cc'] = ':Telekasten show_calendar<CR>'
