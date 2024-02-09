local handlers = require("plugins/lsp/handlers")

handlers.setup()

require("mason").setup()

local lspconfig = require("lspconfig")

local servers = {
    "bashls",
    "jsonls",
    "lua_ls",
    "pyright",
    "tsserver",
    "clangd",
}

for _, server in pairs(servers) do
    local opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
    }

    if server == "clangd" then
        -- fixes a bug in clangd
        opts.cmd = {
            "clangd",
            "--offset-encoding=utf-16",
        }
    end

    local has_custom_opts, server_custom_opts = pcall(require, "plugins/lsp/settings/" .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
    end

    lspconfig[server].setup(opts)
end

require("mason-lspconfig").setup({
    ensure_installed = servers,
})
