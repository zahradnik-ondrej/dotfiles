lvim.format_on_save.enabled = true

local docformatter = {
  exe = "docformatter",
  args = {
    "--in-place",
    "--wrap-summaries", "120",
    "--wrap-descriptions", "120",
  },
  stdin = false,
}

local black = {
  exe = "black",
  args = { "--line-length", "120" },
  stdin = false,
}

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "docformatter", filetypes = { "python" }, args = docformatter.args },
  { command = "black",        filetypes = { "python" }, args = black.args },
})
