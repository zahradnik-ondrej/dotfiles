lvim.colorscheme = "dracula"
lvim.builtin.bufferline.active = false
vim.opt.relativenumber = true -- relative line numbers
lvim.transparent_window = false

lvim.builtin.which_key.mappings["Q"] = { "<cmd>qa<CR>", "Quit LunarVim" }
lvim.builtin.which_key.mappings["cs"] = { ":tabnew $HOME/lunarvim_cheatsheet.md<CR>", "Open LunarVim Cheatsheet" }
lvim.builtin.which_key.mappings["h"] = { lvim.builtin.which_key.mappings["h"][1], "Clear Highlighting" }
lvim.keys.normal_mode["<C-w>h"] = "<C-w>s"                                              -- horizontal window split
lvim.builtin.which_key.mappings["/"] = { lvim.builtin.which_key.mappings["/"][1], "Comment / Uncomment" }
lvim.keys.normal_mode["YA"] = ":<C-U>%y+<CR>"                                           -- copy entire file's content
lvim.keys.normal_mode["DA"] = ":<C-U>%d<CR>"                                            -- delete entire file's content
lvim.builtin.which_key.mappings["T"] = { ":terminal<CR>", "Open Terminal" }
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true }) -- enter normal mode from terminal window

lvim.builtin.which_key.mappings["t"] = {
  name = "Tabs",
  t = { ":tabnew<CR>", "New Tab" },
  q = { ":tabclose<CR>", "Close Tab" },
  n = { ":tabnext<CR>", "Next Tab" },
  p = { ":tabprev<CR>", "Previous Tab" },
}

lvim.keys.normal_mode["<C-n>"] = ":tabnext<CR>"
lvim.keys.normal_mode["<C-p>"] = ":tabprev<CR>"

lvim.builtin.which_key.mappings["q"] = { "<cmd>q<CR>", "Close File" }
lvim.builtin.which_key.mappings["w"] = { "<cmd>w<CR>", "Save File" }

lvim.builtin.which_key.mappings["s"] = {
  name = lvim.builtin.which_key.mappings["s"].name,
  b = nil,
  c = { ":Telescope colorscheme<CR>", "Change Colorscheme" },
  C = { lvim.builtin.which_key.mappings["s"]["C"][1], lvim.builtin.which_key.mappings["s"]["C"][2] },
  f = nil,
  H = { lvim.builtin.which_key.mappings["s"]["H"][1], lvim.builtin.which_key.mappings["s"]["H"][2] },
  h = nil,
  k = { lvim.builtin.which_key.mappings["s"]["k"][1], lvim.builtin.which_key.mappings["s"]["k"][2] },
  l = nil,
  M = { lvim.builtin.which_key.mappings["s"]["M"][1], lvim.builtin.which_key.mappings["s"]["M"][2] },
  p = nil,
  R = { lvim.builtin.which_key.mappings["s"]["R"][1], lvim.builtin.which_key.mappings["s"]["R"][2] },
  r = nil,
  t = nil,
}

-- local auto_save_enabled
-- local format_on_save_enabled

-- -- Function to load the saved states from a file
-- local function load_settings()
--   local settings_file = vim.fn.stdpath("config") .. "/auto_save_settings.json"
--   local settings = {}

--   if vim.fn.filereadable(settings_file) == 1 then
--     local file = io.open(settings_file, "r")
--     local content = file:read("*a")
--     file:close()
--     settings = vim.fn.json_decode(content)
--   end

--   -- Set values only if settings are found in the JSON, otherwise set defaults
--   auto_save_enabled = settings.auto_save_enabled == nil and true or settings.auto_save_enabled
--   format_on_save_enabled = settings.format_on_save_enabled == nil and true or settings.format_on_save_enabled
-- end

-- -- Function to save the current states to a file
-- local function save_settings()
--   local settings = {
--     auto_save_enabled = auto_save_enabled,
--     format_on_save_enabled = format_on_save_enabled,
--   }

--   local settings_file = vim.fn.stdpath("config") .. "/auto_save_settings.json"
--   local file = io.open(settings_file, "w")
--   file:write(vim.fn.json_encode(settings))
--   file:close()
-- end

-- -- Load the settings on startup
-- load_settings()

-- -- Apply settings to `lvim.format_on_save.enabled`
-- lvim.format_on_save = lvim.format_on_save or {}
-- lvim.format_on_save.enabled = format_on_save_enabled

-- -- Auto-save setup (moved from auto-save.lua)
-- require("auto-save").setup({
--   enabled = auto_save_enabled,
--   execution_message = {
--     message = function()
--       return "Auto-Saved at " .. vim.fn.strftime("%H:%M:%S")
--     end,
--   },
--   trigger_events = { "InsertLeave", "TextChanged" },
--   conditions = {
--     exists = true,
--     modifiable = true,
--   },
--   debounce_delay = 135,
-- })

-- -- Keybindings for toggling auto-save and auto-formatting
-- lvim.builtin.which_key.mappings["a"] = {
--   name = "Automatic Functions",
--   f = {
--     function()
--       -- Toggle the state of auto-formatting
--       format_on_save_enabled = not format_on_save_enabled
--       lvim.format_on_save.enabled = format_on_save_enabled
--       print("Auto-formatting " .. (format_on_save_enabled and "enabled" or "disabled"))
--       save_settings()
--     end,
--     "Toggle Auto-formatting",
--   },
--   s = {
--     function()
--       -- Toggle the state of auto-save
--       auto_save_enabled = not auto_save_enabled
--       require("auto-save").setup({ enabled = auto_save_enabled })
--       print("Auto-saving " .. (auto_save_enabled and "enabled" or "disabled"))
--       save_settings()
--     end,
--     "Toggle Auto-saving",
--   },
-- }

-- -- Save settings after each session or toggle action
-- save_settings()

lvim.builtin.which_key.mappings["a"] = {
  name = "Automatic Functions",
  f = {
    function()
      lvim.format_on_save = not lvim.format_on_save
      local status = lvim.format_on_save and "enabled" or "disabled"
      print("Auto-formatting " .. status)
    end,
    "Toggle Auto-formatting",
  },
  s = {
    ":ASToggle<CR>",
    "Toggle Auto-saving",
  },
}

lvim.builtin.which_key.mappings["T"] = nil -- unbind <leader> T (Treesitter)
lvim.builtin.which_key.mappings["b"] = nil -- unbind <leader> b (Buffers)
lvim.builtin.which_key.mappings["c"] = nil -- unbind <leader> c (Close Buffer)
