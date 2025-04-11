local ascii = require("ascii")

local dashboard = require("alpha.themes.dashboard")

dashboard.section.buttons.opts = {
  spacing = 0,
}

dashboard.section.buttons.val = {
    dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
    dashboard.button("g", "󱎸  Live Grep", ":Telescope live_grep<CR>"),
    dashboard.button("r", "󰋚  View Recent Files", ":Telescope oldfiles<CR>"),
    dashboard.button("s", "󱝩  Select Session", ":lua require('persistence').select()<CR>"),
    dashboard.button("l", "󱝥  Load Last Session", ":lua require('persistence').load({ last = true })<CR>"),
    dashboard.button("p", "  View All Projects", ":Telescope projects<CR>"),
    dashboard.button("m", "󰘦  Search Man Pages", ":Telescope man_pages<CR>"),
    dashboard.button("e", "󰙅  Toggle File Explorer", ":Neotree toggle<CR>"),
    dashboard.button("o", "  Open New File", ":enew<CR>"),
    dashboard.button("b", "  List Bookmarks", ":Telescope vim_bookmarks all<CR>"),
    dashboard.button("n", "󱘒  New Note", ":Telekasten new_note<CR>"),
    dashboard.button("k", "  Show Calendar", ":Telekasten show_calendar<CR>"),
    dashboard.button("x", "󰍜  Find Notes", ":Telekasten find_notes<CR>"),
    dashboard.button("t", "  Open Terminal", ":ToggleTerm<CR>"),
    dashboard.button("c", "  Change Colorscheme", ":Telescope colorscheme<CR>"),
    dashboard.button("h", "󰋖  Open LunarVim Cheatsheet", ":tabnew " .. vim.fn.stdpath("config") .. "/lunarvim_cheatsheet.md<CR>"),
    dashboard.button("q", "󰅖  Quit", ":q<CR>"),
}

-- lvim.builtin.alpha.dashboard.section.header.val = ascii.art.anime.onepiece.robin
-- lvim.builtin.alpha.dashboard.section.header.val = ascii.get_random("anime", "onepiece")
lvim.builtin.alpha.dashboard.section.buttons = dashboard.section.buttons
lvim.builtin.alpha.dashboard.section.footer.val = ""

lvim.builtin.alpha.dashboard.section.header.val = {
  "                                                         .         .           ",
  "    ,o888888o.  `8.`888b           ,8'  8 8888          ,8.       ,8.          ",
  " . 8888     `88. `8.`888b         ,8'   8 8888         ,888.     ,888.         ",
  ",8 8888       `8b `8.`888b       ,8'    8 8888        .`8888.   .`8888.        ",
  "88 8888        `8b `8.`888b     ,8'     8 8888       ,8.`8888. ,8.`8888.       ",
  "88 8888         88  `8.`888b   ,8'      8 8888      ,8'8.`8888,8^8.`8888.      ",
  "88 8888         88   `8.`888b ,8'       8 8888     ,8' `8.`8888' `8.`8888.     ",
  "88 8888        ,8P    `8.`888b8'        8 8888    ,8'   `8.`88'   `8.`8888.    ",
  "`8 8888       ,8P      `8.`888'         8 8888   ,8'     `8.`'     `8.`8888.   ",
  " ` 8888     ,88'        `8.`8'          8 8888  ,8'       `8        `8.`8888.  ",
  "    `8888888P'           `8.`           8 8888 ,8'         `         `8.`8888. ",
}
