lvim.builtin.nvimtree.active = false
lvim.builtin.which_key.mappings["e"] = { ":Neotree toggle<CR>", "Toggle File Explorer" }

require("neo-tree").setup({
  close_if_last_window = true,
  enable_git_status = true,
  filesystem = {
    use_libuv_file_watcher = true,
  },
  window = {
    position = "float",
    popup = {
      size = {
        height = "80%",
        width = "50%",
      },
      border = "rounded",
    },
  },
})
