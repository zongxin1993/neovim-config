local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "plugin.lsp.configs"
require("plugin.lsp.handlers").setup()
require "plugin.lsp.null-ls"
--require "plugin.lsp.lsp-colors"
--require "plugin.lsp.lsp-trouble"
--require "plugin.lsp.lspsaga"
