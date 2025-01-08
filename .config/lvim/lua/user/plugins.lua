lvim.plugins = {
  { "morhetz/gruvbox" },
  { "catppuccin/nvim" },
  { "dracula/vim" },
  { "szw/vim-maximizer" },
  -- { "sindrets/diffview.nvim" },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
  },
  { "tpope/vim-surround" },
  { "renerocksai/telekasten.nvim" },
  { "mattn/calendar-vim" },
  { "Pocco81/auto-save.nvim" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  { "smoka7/hop.nvim" },
  { "christoomey/vim-tmux-navigator" },
}
