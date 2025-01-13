lvim.plugins = {
  { "morhetz/gruvbox" },
  { "catppuccin/nvim" },
  { "dracula/vim" },
  { "szw/vim-maximizer" },
  {
    "sindrets/diffview.nvim",
    config = function()
      require('diffview').setup {
        enhanced_diff_hl = true
      }
    end,
  },
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
  { "MaximilianLloyd/ascii.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
  {
        "folke/trouble.nvim",
        cmd = "Trouble",
        config = function()
            require("trouble").setup({})
        end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({})
    end,
  },
  { "MattesGroeger/vim-bookmarks" },
  { "tom-anders/telescope-vim-bookmarks.nvim" },
}
