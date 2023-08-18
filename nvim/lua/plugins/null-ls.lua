local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,
    sources = {
        formatting.prettierd,
        formatting.stylua,
        formatting.eslint_d,
        diagnostics.eslint_d,
        code_actions.eslint_d,
        -- formatting.eslint,
        -- diagnostics.eslint,
        -- code_actions.eslint,
        diagnostics.shellcheck,
        -- diagnostics.checkstyle.with({
        --     extra_args = { "-c", "/Users/ggrangel/.config/nvim/configuration/java/fintech-business-checkstyle.xml" },
        -- }),
        code_actions.shellcheck,
        code_actions.gitsigns,
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
