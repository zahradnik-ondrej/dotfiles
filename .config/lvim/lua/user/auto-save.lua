require("auto-save").setup({
  enabled = false,
  execution_message = {
    message = function()
      return "Auto-Saved at " .. vim.fn.strftime("%H:%M:%S")
    end,
  },
  trigger_events = { "InsertLeave", "TextChanged" },
  conditions = {
    exists = true,
    modifiable = true,
  },
  debounce_delay = 5000,
})
