return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    },

    config = function()
      local lsp = require("lsp-zero").preset({})

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)

      lsp.ensure_installed({
        "intelephense",
        "tsserver",
        "clangd",
        "volar",
      })

      require("lspconfig").intelephense.setup({
        settings = {
          -- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#configuration-options
          intelephense = {
            files = {
              exclude = {
                "**/.git/**",
                "**/.svn/**",
                "**/.hg/**",
                "**/CVS/**",
                "**/.DS_Store/**",
                "**/node_modules/**",
                "**/bower_components/**",
                "**/vendor/**/{Tests,tests}/**",
                "**/.history/**",
                "**/vendor/**/vendor/**",
                "**/var/cache/**",
              },
            },
          },
        },
      })

      lsp.setup()
    end,
  },
}
