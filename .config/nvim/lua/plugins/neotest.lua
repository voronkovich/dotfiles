return {
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        "neotest-phpunit",
      },
    },
    keys = {
      {
        "<Leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last",
      },
    },
  },
  {
    -- PHPUnit
    "olimorris/neotest-phpunit",
    dependencies = {
      "nvim-neotest/neotest",
    },
    opts = {
      phpunit_cmd = function()
        local phpunit = "phpunit"
        if vim.fn.filereadable("vendor/bin/phpunit") == 1 then
          -- Composer
          phpunit = "vendor/bin/phpunit"
        elseif vim.fn.filereadable("bin/phpunit") == 1 then
          -- Symfony
          phpunit = "bin/phpunit"
        elseif vim.fn.filereadable("tools/phpunit") == 1 then
          -- Phive
          phpunit = "tools/phpunit"
        end

        -- DDEV
        -- Doesn't work: https://github.com/olimorris/neotest-phpunit/issues/11
        if vim.fn.filereadable(".ddev/config.yaml") == 1 then
          return {
            "ddev",
            "exec",
            "--",
            phpunit,
          }
        end

        -- Symfony CLI
        if vim.fn.executable("symfony") == 1 and vim.fn.filereadable("symfony.lock") == 1 then
          return {
            "symfony",
            "php",
            phpunit,
          }
        end

        return phpunit
      end,
    },
    config = function(_, opts)
      require("neotest-phpunit")(opts)
    end,
  },
}
