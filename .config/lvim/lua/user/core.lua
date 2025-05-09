-- lvim.colorscheme = "dracula"
-- lvim.transparent_window = true
lvim.builtin.bufferline.active = false
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true
lvim.builtin.terminal.active = true
vim.opt.expandtab = true

local ok, persist = pcall(require, "user.persist")
if ok then
  vim.g.persist = persist
  if persist.theme then
    lvim.colorscheme = persist.theme
    vim.g._transparency_override = true
    vim.cmd("colorscheme " .. persist.theme)
    vim.g._transparency_override = false
  end
end

lvim.keys.normal_mode["<C-w>h"] = "<C-w>s" -- horizontal window split

lvim.keys.normal_mode["YA"] = ":<C-U>%y+<CR>"                                           -- copy entire file's content
lvim.keys.normal_mode["DA"] = ":<C-U>%d<CR>"                                            -- delete entire file's content

-- vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true }) -- cycle through windows from terminal mode
-- vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true }) -- enter normal mode from terminal window

lvim.keys.normal_mode["<C-J>"] = "ddjP"
lvim.keys.normal_mode["<C-K>"] = "ddkP"

lvim.keys.normal_mode["<C-m>"] = ":MaximizerToggle<CR>"

lvim.keys.normal_mode["<C-n>"] = ":tabnext<CR>"
lvim.keys.normal_mode["<C-p>"] = ":tabprev<CR>"

require("telescope").load_extension("vim_bookmarks")
vim.g.bookmark_sign = ""
vim.g.bookmark_annotation_sign = ""

lvim.builtin.terminal.open_mapping = "<C-t>"
lvim.builtin.terminal.directiontion = "horizontal"

vim.api.nvim_set_keymap("n", "<C-i>", "<C-o>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-o>", "<C-i>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    if vim.g._transparency_override then return end

    if vim.g.persist and vim.g.persist.transparency then
      vim.defer_fn(function()
        for _, group in ipairs({ "Normal", "NormalNC", "TelescopeNormal", "NvimTreeNormal", "FloatBorder" }) do
          vim.cmd("highlight " .. group .. " guibg=none")
        end
      end, 50)
    end

    if vim.g.colors_name then
      UpdatePersistSetting("theme", vim.g.colors_name)
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.g.persist and vim.g.persist.transparency then
      vim.defer_fn(function()
        for _, group in ipairs({ "Normal", "NormalNC", "TelescopeNormal", "NvimTreeNormal", "FloatBorder" }) do
          vim.cmd("highlight " .. group .. " guibg=none")
        end
      end, 100)
    end
  end,
})

function UpdatePersistSetting(key, value)
  local path = vim.fn.stdpath("config") .. "/lua/user/persist.lua"
  local persist = vim.g.persist or {}
  persist[key] = value
  local file = io.open(path, "w")
  if not file then return end
  file:write("return {\n")
  for k, v in pairs(persist) do
    local val = type(v) == "string" and string.format("%q", v) or tostring(v)
    file:write(string.format("  %s = %s,\n", k, val))
  end
  file:write("}\n")
  file:close()
end

vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = false,
})

_G.toggle_diagnostics = function()
  local diagnostic_config_enabled = vim.g.diagnostic_config_enabled or false
  diagnostic_config_enabled = not diagnostic_config_enabled
  vim.g.diagnostic_config_enabled = diagnostic_config_enabled

  vim.diagnostic.config({
    virtual_text = diagnostic_config_enabled,
    signs = diagnostic_config_enabled,
    underline = diagnostic_config_enabled,
  })
  print("Diagnostics " .. (diagnostic_config_enabled and "enabled" or "disabled"))
end

lvim.builtin.illuminate.active = false
