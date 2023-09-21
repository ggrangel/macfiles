local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,
    sources = {
        code_actions.gitsigns,
        code_actions.eslint_d,
        -- diagnostics.checkstyle.with({
        --     extra_args = { "-c", "/Users/ggrangel/.config/nvim/configuration/java/fintech-business-checkstyle.xml" },
        -- }),
        diagnostics.eslint_d,
        formatting.eslint_d,
        formatting.prettierd,
        formatting.stylua,
        formatting.xmlformat.with({
            extra_args = { "--indent", "4" },
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
