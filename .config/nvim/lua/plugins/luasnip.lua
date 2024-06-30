return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "snippets/sniphpets-luasnip",
        dev = true,
        opts = {
          strict_types = true,
          final_classes = true,
          common = {
            enabled = true,
          },
          phpunit = {
            enabled = true,
          },
          symfony = {
            enabled = true,
          },
          doctrine = {
            enabled = true,
          },
          eloquent = {
            enabled = true,
          },
        },
      },
    },
    opts = {
      store_selection_keys = "<Tab>",
    },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)

      require("luasnip.loaders.from_lua").lazy_load({
        paths = vim.fn.stdpath("config") .. "/snippets",
      })
    end,
  },
}
