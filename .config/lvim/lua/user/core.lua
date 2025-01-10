lvim.colorscheme = "dracula"
lvim.builtin.bufferline.active = false
vim.opt.relativenumber = true -- relative line numbers
lvim.transparent_window = true
lvim.builtin.terminal.active = true

lvim.builtin.alpha.dashboard.section.footer.val = ""

lvim.keys.normal_mode["<C-w>h"] = "<C-w>s" -- horizontal window split

lvim.keys.normal_mode["YA"] = ":<C-U>%y+<CR>"                                           -- copy entire file's content
lvim.keys.normal_mode["DA"] = ":<C-U>%d<CR>"                                            -- delete entire file's content

-- vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true }) -- enter normal mode from terminal window

lvim.keys.normal_mode["<C-n>"] = ":tabnext<CR>"
lvim.keys.normal_mode["<C-p>"] = ":tabprev<CR>"

local dashboard = require("alpha.themes.dashboard")

dashboard.section.buttons.opts = {
  spacing = 0,
}

dashboard.section.buttons.val = {
    dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
    dashboard.button("g", "󱎸  Live Grep", ":Telescope live_grep<CR>"),
    dashboard.button("r", "󰋚  View Recent Files", ":Telescope oldfiles<CR>"),
    dashboard.button("p", "  View All Projects", ":Telescope projects<CR>"),
    dashboard.button("m", "󰘦  Search Man Pages", ":Telescope man_pages<CR>"),
    dashboard.button("e", "󰙅  Toggle File Explorer", ":Neotree toggle<CR>"),
    dashboard.button("o", "  Open New File", ":enew<CR>"),
    dashboard.button("n", "󱘒  New Note", ":Telekasten new_note<CR>"),
    dashboard.button("k", "  Show Calendar", ":Telekasten show_calendar<CR>"),
    dashboard.button("x", "󰍜  Find Notes", ":Telekasten find_notes<CR>"),
    dashboard.button("t", "  Open Terminal", ":ToggleTerm<CR>"),
    dashboard.button("c", "  Change Colorscheme", ":Telescope colorscheme<CR>"),
    dashboard.button("h", "󰋖  Open LunarVim Cheatsheet", ":tabnew " .. vim.fn.stdpath("config") .. "/lunarvim_cheatsheet.md<CR>"),
    dashboard.button("q", "󰅖  Quit", ":q<CR>"),
}

lvim.builtin.alpha.dashboard.section.buttons = dashboard.section.buttons

lvim.builtin.terminal.open_mapping = "<C-t>"
lvim.builtin.terminal.direction = "horizontal"
