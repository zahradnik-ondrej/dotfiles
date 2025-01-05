lvim.plugins = {
  { "morhetz/gruvbox" },
  { "catppuccin/nvim" },
  { "dracula/vim" },
  { "szw/vim-maximizer" },
  { "sindrets/diffview.nvim" },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
  },
  { "tpope/vim-surround" },
}
