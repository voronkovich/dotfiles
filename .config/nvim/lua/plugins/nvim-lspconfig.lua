local util = require("lspconfig.util")

return {
  "neovim/nvim-lspconfig",
  opts = {
    -- @type lspconfig.options
    servers = {
      intelephense = {
        filetypes = { "php", "blade", "php_only" },
        root_dir = function(pattern)
          local cwd = vim.loop.cwd()
          local root = util.root_pattern("composer.json", ".git", "index.php")(pattern)

          -- prefer cwd if root is a descendant
          return util.path.is_descendant(cwd, root) and cwd or root
        end,
        settings = {
          intelephense = {
            filetypes = { "php", "blade", "php_only" },
            files = {
              associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
              maxSize = 5000000,
            },
          },
        },
      },
    },
  },
}
