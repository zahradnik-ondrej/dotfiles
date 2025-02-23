lvim.format_on_save.enabled = false

local docformatter = {
  exe = "docformatter",
  args = {
    "--in-place",
    "--wrap-summaries", "120",
    "--wrap-descriptions", "120",
  },
  stdin = true,
}

local black = {
  exe = "black",
  args = { "--line-length", "120" },
  stdin = false,
}

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  -- { command = "docformatter", filetypes = { "python" }, args = docformatter.args, stdin = true },
  { command = "black",        filetypes = { "python" }, args = black.args },
})
