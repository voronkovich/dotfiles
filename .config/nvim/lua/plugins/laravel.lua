return {
  "adalessa/laravel.nvim",
  dependencies = {
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
    "kevinhwang91/promise-async",
  },
  cmd = { "Laravel" },
  keys = {
    { "<leader>la", ":Laravel artisan<cr>" },
    { "<leader>lr", ":Laravel routes<cr>" },
    { "<leader>lm", ":Laravel related<cr>" },
  },
  event = { "VeryLazy" },
  opts = {
    features = {
      pickers = {
        provider = "fzf-lua",
      },
    },
    environments = {
      default = "symfony",
      definitions = {
        {
          name = "symfony",
          condition = {
            executable = { "symfony" },
          },
          commands = {
            symfony = { "symfony" },
            {
              commands = { "php", "composer" },
              prefix = { "symfony" },
            },
          },
        },
      },
    },
  },
  config = true,
}
