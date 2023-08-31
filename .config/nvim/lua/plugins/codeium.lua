return {
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.g.codeium_no_map_tab = true
    end,
    keys = {
      {
        "<C-g>",
        function()
          return vim.fn["codeium#Accept"]()
        end,
        mode = "i",
        expr = true,
        desc = "Codeium Accept",
      },
    },
  },
  {
    "jcdickinson/codeium.nvim",
    -- https://github.com/jcdickinson/codeium.nvim/issues/80
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },
}
