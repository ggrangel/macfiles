-- Modes
-- normal = n
-- insert = i
-- visual = v
-- visual_block = x
-- term = t
-- command = c
local keymap = vim.keymap.set

vim.g.mapleader = " "

-- keymap("n", "<leader>A", ":wa | lua vim.notify('Project saved') <CR>")
keymap("n", "<leader>S", ":wa | bbr | lua vim.notify('Config sourced') <CR>", { silent = true })
keymap("n", "<leader>N", ":Nredir Notifications <CR>") -- opens notification in new window

-- open links
keymap("n", "gx", [[<cmd>silent !open <cfile><cr>]])

vim.cmd([[let g:winresizer_start_key = ',W']]) --> window resize

-- Opens nvim-tree pointing to current file
keymap("n", "<leader>t", ":NvimTreeFindFile <CR>")

--> LuaSnip <--
vim.api.nvim_create_user_command("LuaSnipEdit", require("luasnip.loaders.from_lua").edit_snippet_files, {})
keymap("n", "<leader><CR>", "<cmd>LuaSnipEdit<cr>")
keymap(
    "n",
    "<leader>L",
    ":source ~/.config/nvim/lua/plugins/luasnip-setup.lua | lua vim.notify('Luasnip sourced') <CR>"
)

-- Lualine
keymap("n", "<leader>ls", function()
    local lualine = require("lualine")
    if vim.o.ls == 0 then
        lualine.hide({ unhide = true })
    else
        lualine.hide()
    end
end)

-- Show command status: useful when you're recording a query
keymap("n", "<leader>ch", function()
    if vim.o.ch == 0 then
        vim.o.ch = 1
    else
        vim.o.ch = 0
    end
end)

-- Mirrors vim-surround keybindings to vim-sandwich
--> ys, yss, yS, ds, cs, S, dss, css
vim.cmd([[
runtime macros/sandwich/keymap/surround.vim
]])

---- Navigate tabs
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

--- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

---- Telescope
keymap("n", "<leader>ff", function()
    return require("telescope.builtin").find_files()
end)
keymap("n", "<leader>fl", function()
    return require("telescope.builtin").live_grep()
end)
keymap("n", "<leader>fi", function()
    return require("telescope.builtin").git_files()
    -- return require("telescope").extensions.frecency.frecency({ workspace = "CWD" })
end)
keymap("n", "<leader>fb", function()
    return require("telescope.builtin").buffers()
end)
keymap("n", "<leader>fh", function()
    return require("telescope.builtin").help_tags()
end)

--- Trouble
keymap("n", "<leader>xd", ":Trouble workspace_diagnostics <CR>")
keymap("n", "<leader>xx", ":TroubleToggle <CR>")

-- close other tab
keymap("n", "<C-q>h", "<C-w>h :q <CR>")
keymap("n", "<C-q>l", "<C-w>l :q <CR>")
keymap("n", "<C-q>k", "<C-w>k :q <CR>")
keymap("n", "<C-q>j", "<C-w>j :q <CR>")

--> LSP <--
-- keymap("n", ",r", function()
--     return vim.lsp.buf.format({
--         -- Never request typescript-language-server for formatting (leave it to prettier)
--         filter = function(client)
--             return client.name ~= "tsserver"
--         end,
--     })
-- end)

keymap("n", ",r", vim.lsp.buf.format)
keymap("n", "gD", vim.lsp.buf.declaration)
keymap("n", "gd", vim.lsp.buf.definition)
keymap("n", "K", vim.lsp.buf.hover)
keymap("n", "gi", vim.lsp.buf.implementation)
keymap("n", "<C-k>", vim.lsp.buf.signature_help)
keymap("n", "<leader>gt", vim.lsp.buf.type_definition)
keymap("n", "<leader>rn", ":Lspsaga rename mode=n <CR>")
keymap("n", "gr", ":Lspsaga finder <CR>")
-- keymap("n", "<leader>ca", vim.lsp.buf.code_action)
keymap("n", "<leader>ca", ":Lspsaga code_action <CR>")
keymap("n", "[d", function()
    return vim.diagnostic.goto_prev({ border = "rounded" })
end)
keymap("n", "]d", function()
    return vim.diagnostic.goto_next({ border = "rounded" })
end)
keymap("n", "gl", function()
    return vim.diagnostic.open_float({ border = "rounded" })
end)

-- Harpoon
keymap("n", "<leader>hr", function()
    vim.notify("You threw a harpoon", vim.log.levels.INFO)
    return require("harpoon.mark").add_file()
end)
keymap("n", "<leader>hh", function()
    return require("harpoon.ui").toggle_quick_menu()
end)
local hkeys = { "a", "s", "d", "f", "g" }
for i = 1, 5 do
    keymap("n", "<leader>h" .. hkeys[i], function()
        return require("harpoon.ui").nav_file(i)
    end)
end

local function harpoon_send_command_to_tmux(command, tab_name, notify_message)
    -- TODO:
    -- 1. get the workspace from which this command was called
    -- 2. cd to the WS root folder
    -- 3. execute the commmand
    vim.notify(notify_message)
    local command_with_sound_notification = command .. " && say 'Success' || say 'Fail'"
    return require("harpoon.tmux").sendCommand(tab_name, command_with_sound_notification)
end

keymap("n", "<leader>hb", function()
    local command = "brazil-build release"
    local tab_name = "root.1"
    local notify_message = "Local build initiated in tab " .. tab_name
    harpoon_send_command_to_tmux(command, tab_name, notify_message)
end)
keymap("n", "<leader>hB", function()
    local command = "brazil-build release"
    local tab_name = "root.2"
    local notify_message = "Remote build initiated in tab " .. tab_name
    harpoon_send_command_to_tmux(command, tab_name, notify_message)
end)
keymap("n", "<leader>ht", function()
    local command = "brazil-build test"
    local tab_name = "root.1"
    local notify_message = "Local test initiated in tab " .. tab_name
    harpoon_send_command_to_tmux(command, tab_name, notify_message)
end)
keymap("n", "<leader>hT", function()
    local command = "brazil-build test"
    local tab_name = "root.2"
    local notify_message = "Remote test initiated in tab " .. tab_name
    harpoon_send_command_to_tmux(command, tab_name, notify_message)
end)
keymap("n", "<leader>hq", function()
    local command = "!!"
    local tab_name = "root.1"
    local notify_message = "Running last local executed command in tab " .. tab_name
    harpoon_send_command_to_tmux(command, tab_name, notify_message)
end)
keymap("n", "<leader>hQ", function()
    local command = "!!"
    local tab_name = "root.2"
    local notify_message = "Running last remoted executed command in tab " .. tab_name
    harpoon_send_command_to_tmux(command, tab_name, notify_message)
end)

--- yanky.nvim
-- The first 4 mapppings are required
keymap({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
keymap({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
keymap({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
keymap({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
keymap("n", "<c-n>", "<Plug>(YankyCycleForward)")  -- cycling through yank history
keymap("n", "<c-p>", "<Plug>(YankyCycleBackward)") -- paste what's before on buffer

local function map(m, k, v, desc)
    if desc then
        desc = "Desc: " .. desc
    end
    vim.keymap.set(m, k, v, { silent = true }, { desc = desc })
end

-- test
keymap("n", ",t", ":TestFile <CR>")
keymap("n", ",T", ":TestNearest <CR>")
-- jump to alternate file (https://github.com/tpope/vim-projectionist)
keymap("n", ",a", ":A <CR>")
-- vsplit alternate file
keymap("n", ",A", ":AV <CR>")

map("n", "<C-w>", ":CWGenerateNvim<CR>")
