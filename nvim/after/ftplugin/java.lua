local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local config = {
  cmd = {
    "/usr/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1 ",
    "-Dosgi.bundles.defaultStartLevel=4 ",
    "-Declipse.product=org.eclipse.jdt.ls.core.product ",
    "-Dlog.level=ALL ",
    "-noverify ",
    "-Xmx1G ",
    "	-jar",
    "/Library/java/jdt-language-server-1.9.0-202203031534/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    "	-configuration",
    "/Library/java/jdt-language-server-1.9.0-202203031534/config_mac/",
    "	-data",
    vim.fn.expand("~/.cache/jdtls-workspace") .. workspace_dir,
  },
  -- root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
  capabilities = capabilities,
}
require("jdtls").start_or_attach(config)

-- local keymap = vim.keymap.set
--
-- keymap("n", "gD", vim.lsp.buf.declaration)
-- keymap("n", "gd", vim.lsp.buf.definition)
-- keymap("n", "K", vim.lsp.buf.hover)
-- keymap("n", "gi", vim.lsp.buf.implementation)
-- keymap("n", "<C-k>", vim.lsp.buf.signature_help)
-- keymap("n", "<space>gt", vim.lsp.buf.type_definition)
-- -- keymap("n", "gr", vim.lsp.buf.references) -- handled by trouble.nvim
-- keymap("n", "<leader>ca", vim.lsp.buf.code_action)
-- keymap("n", "[d", function()
--   return vim.diagnostic.goto_prev({ border = "rounded" })
-- end)
-- keymap("n", "]d", function()
--   return vim.diagnostic.goto_next({ border = "rounded" })
-- end)
-- keymap("n", "gl", function()
--   return vim.diagnostic.open_float({ border = "rounded" })
-- end)
