return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "pint", "php_cs_fixer" },
      },
      formatters = {
        php_cs_fixer = {
          env = {
            PHP_CS_FIXER_IGNORE_ENV = "1",
          },
        },
      },
    },
  },
}
