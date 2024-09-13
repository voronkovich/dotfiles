local util = require("lspconfig.util")

return {
  "neovim/nvim-lspconfig",
  opts = {
    -- @type lspconfig.options
    servers = {
      phpactor = {
        root_dir = function(pattern)
          local cwd = vim.loop.cwd()
          local root = util.root_pattern("composer.json", ".git", "index.php")(pattern)

          -- prefer cwd if root is a descendant
          return util.path.is_descendant(cwd, root) and cwd or root
        end,
      },
    },
  },
}
