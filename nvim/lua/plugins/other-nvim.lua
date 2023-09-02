require("other-nvim").setup({
    mappings = {
        {
            pattern = "src/(.*)/src/(.*).ts",
            target = "src/%1/test/%2.test.ts",
        },
        {
            pattern = "src/(.*)/test/(.*).test.ts",
            target = "src/%1/src/%2.ts",
        },
        {
            pattern = "src/(.*)/src/(.*).tsx",
            target = "src/%1/tst/%2.test.tsx",
        },
        {
            pattern = "src/(.*)/tst/(.*).test.tsx",
            target = "src/%1/src/%2.tsx",
        },
    },
    style = {
        -- How the plugin paints its window borders
        -- Allowed values are none, single, double, rounded, solid and shadow
        border = "solid",

        -- Column seperator for the window
        seperator = "|",

        -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
        width = 0.7,

        -- min height in rows.
        -- when more columns are needed this value is extended automatically
        minHeight = 2,
    },
})
