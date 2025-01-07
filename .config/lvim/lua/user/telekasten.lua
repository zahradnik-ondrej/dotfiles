require('telekasten').setup {
  home = vim.fn.expand("$HOME/.notes"),
  dailies = "daily",
  extension = ".md",
  new_note_location = "home",
}

-- show calendar
lvim.keys.normal_mode['<leader>nc'] = ':Telekasten show_calendar<CR>'

-- new day-agnostic note
lvim.keys.normal_mode['<leader>nn'] = ':Telekasten new_note<CR>'

-- find notes
lvim.keys.normal_mode['<leader>nf'] = ':Telekasten find_notes<CR>'
