-- Modes
-- normal = n
-- insert = i
-- visual = v
-- visual_block = x
-- term = t
-- command = c
local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("n", "<leader>N", ":Nredir Notifications <CR>") -- opens notification in new window

-- open links
keymap("n", "gx", [[<cmd>silent !open <cfile><cr>]])

vim.cmd([[let g:winresizer_start_key = '<leader>W']]) --> window resize

-- Opens nvim-tree pointing to current file
keymap("n", "<leader>T", ":NvimTreeFindFile <CR>")

--> LuaSnip <--
-- vim.api.nvim_create_user_command("LuaSnipEdit", require("luasnip.loaders.from_lua").edit_snippet_files, {})
-- keymap("n", "<leader><CR>", "<cmd>LuaSnipEdit<cr>")
-- keymap(
--     "n",
--     "<leader>L",
--     ":source ~/.config/nvim/lua/plugins/luasnip-setup.lua | lua vim.notify('Luasnip sourced') <CR>"
-- )
--

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

-- Close other tabs
keymap("n", "<leader>qh", "<C-w>h :q <CR>")
keymap("n", "<leader>ql", "<C-w>l :q <CR>")
keymap("n", "<leader>qk", "<C-w>k :q <CR>")
keymap("n", "<leader>qj", "<C-w>j :q <CR>")

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

--> LSP <--
-- keymap("n", ",r", function()
--     return vim.lsp.buf.format({
--         -- Never request typescript-language-server for formatting (leave it to prettier)
--         filter = function(client)
--             return client.name ~= "tsserver"
--         end,
--     })
-- end)

keymap("n", "<leader>F", vim.lsp.buf.format)
keymap("n", "gD", vim.lsp.buf.declaration)
keymap("n", "gd", vim.lsp.buf.definition)
keymap("n", "K", vim.lsp.buf.hover)
keymap("n", "gi", vim.lsp.buf.implementation)
keymap("n", "<C-k>", vim.lsp.buf.signature_help)
keymap("n", "<leader>gt", vim.lsp.buf.type_definition)
-- keymap("n", "<leader>rn", ":Lspsaga rename mode=n <CR>")
keymap("n", "<leader>rn", vim.lsp.buf.rename)
keymap("n", "gr", ":Lspsaga finder <CR>")
keymap("n", "<leader>ca", vim.lsp.buf.code_action)
-- keymap("n", "<leader>ca", ":Lspsaga code_action <CR>")
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
	vim.cmd(":wa")
	local harpoon_tmux = require("harpoon.tmux")

	local cwd = vim.fn.getcwd()
	local cd_command = "cd " .. cwd
	local sound_notification = "say 'Success' || say 'Fail'"
	local AND = " && "
	local cd_plus_command_plus_sound = cd_command .. AND .. command .. AND .. sound_notification

	vim.notify(notify_message)
	-- This first command is in case normal mode is on, or if there's already something written in the prompt
	harpoon_tmux.sendCommand(tab_name, "i")
	harpoon_tmux.sendCommand(tab_name, cd_plus_command_plus_sound)
end

keymap("n", "<leader>hq", function()
	-- TODO:
	-- get custom command from user input: vim.ui.input
	local command = ""
	local tab_name = "root.1"
	local notify_message = "Running " .. command .. " initiated in tab " .. tab_name
	harpoon_send_command_to_tmux(command, tab_name, notify_message)
end)
keymap("n", "<leader>hQ", function()
	-- TODO:
	-- get custom command from user input: vim.ui.input
	local command = ""
	local tab_name = "root.2"
	local notify_message = "Running " .. command .. " initiated in tab " .. tab_name
	harpoon_send_command_to_tmux(command, tab_name, notify_message)
end)

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
keymap("n", "<leader>hl", function()
	local command = "!!"
	local tab_name = "root.1"
	local notify_message = "Running last local executed command in tab " .. tab_name
	harpoon_send_command_to_tmux(command, tab_name, notify_message)
end)
keymap("n", "<leader>hL", function()
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

-- test
keymap("n", "<leader>te", ":wa | TestFile <CR>")
keymap("n", "<leader>tn", ":wa | TestNearest <CR>")

-- other.nvim: honoring legacy shortcut
keymap("n", ":A", ":Other <CR>")
keymap("n", ":AV", ":OtherVSplit <CR>")

-- local function map(m, k, v, desc)
--     if desc then
--         desc = "Desc: " .. desc
--     end
--     vim.keymap.set(m, k, v, { silent = true }, { desc = desc })
-- end
-- keymap("n", "<C-w>", ":CWGenerateNvim<CR>")
