-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.env.LSP_DEBUG then
  vim.lsp.set_log_level("debug")
  if vim.fn.has("nvim-0.5.1") == 1 then
    require("vim.lsp.log").set_format_func(vim.inspect)
  end
end
