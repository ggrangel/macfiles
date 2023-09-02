local cmp = require("cmp")
-- local luasnip = require("luasnip")
local lspkind = require("lspkind")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
    -- snippet = {
    --     expand = function(args)
    --         luasnip.lsp_expand(args.body)
    --     end,
    -- },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-y>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
    },
    formatting = {
        --> fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                nvim_lsp = "[LSP]",
                nvim_lua = "[NV-LUA]",
                -- luasnip = "[Snip]",
                buffer = "[Buff]",
                path = "[Path]",
            },
        }),
    },
    sources = {
        { name = "nvim_lsp" },
        -- { name = "luasnip" },
        { name = "path" },
        { name = "nvim_lua" }, -- lua nvim API
        { name = "buffer",  max_item_count = 5, keyword_length = 5 },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    experimental = {
        ghost_text = false,
        native_menu = false,
    },
})
