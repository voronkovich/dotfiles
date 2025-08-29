return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "pint", "php_cs_fixer", stop_after_first = true },
        blade = { "blade-formatter", stop_after_first = true },
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
