local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "lulz.lsp.mason"
require("lulz.lsp.handlers").setup()
require "lulz.lsp.null-ls"
