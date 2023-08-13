local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "phaazon/hop.nvim",
    lazy = false,
    config = function()
      require'hop'.setup()
    end,
  },

  -- https://github.com/gbprod/phpactor.nvim/issues/13#issuecomment-1580372976
  {
    "gbprod/phpactor.nvim",
    ft = "php",
    opts = {
      install = {
        path = vim.fn.stdpath("data") .. "/mason/phpactor",
        bin = vim.fn.stdpath("data") .. "/mason/bin/phpactor",
      },
    },
    keys = {
      {
        "<leader>m",
        function()
          require("phpactor").rpc("context_menu", {})
        end,
        desc = "PhpActor: context menu",
      },
      {
        "<leader>ua",
        function()
          require("phpactor").rpc("import_class", {})
        end,
        desc = "PhpActor: import class",
      },
    },
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
