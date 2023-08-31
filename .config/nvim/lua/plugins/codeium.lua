return {
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
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
