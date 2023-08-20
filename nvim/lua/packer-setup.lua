-- Reloads vim whenever you save this file
vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd(
    "BufWritePost",
    { pattern = { "packer-setup.lua" }, command = "source <afile> | PackerSync", group = "packer_user_config" }
)

-- Have packer use a popup window
require("packer").init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return require("packer").startup(function()
    use("wbthomason/packer.nvim")
    use("mfussenegger/nvim-jdtls")
    -- use "/home/rangelgbr/apps/plugins/autosnips/"

    -- Misc

    -- use("sbulav/nredir.nvim")

    use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in Neovim to improve startup time.
    use({
        "vimwiki/vimwiki",
        config = function()
            require("plugins.vimwiki")
        end,
    })
    -- use "tpope/vim-sleuth" -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file... not working anymore?
    use("dstein64/vim-startuptime")
    -- use({
    --   "iamcco/markdown-preview.nvim",
    --   run = function()
    --     vim.fn["mkdp#util#install"]()
    --   end,
    -- })
    -- use({
    --   "Pocco81/auto-save.nvim",
    --   config = function()
    --     require("plugins.autosave") -- using only in markdown files
    --   end,
    -- })

    -- use({
    --   "karb94/neoscroll.nvim",
    --   config = function()
    --     require("neoscroll").setup() -- better scroll
    --   end,
    -- })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end,
    })
    use("p00f/nvim-ts-rainbow") -- colored parentheses
    use({ "nvim-treesitter/playground" })
    use("RRethy/nvim-treesitter-textsubjects")
    use("nvim-treesitter/nvim-treesitter-textobjects") -- define custom textobjects (like "f" for function and "c" for conditionals)
    use("nvim-treesitter/nvim-treesitter-context")  -- sticky header for context

    -- Navigation
    use({
        "unblevable/quick-scope",
        config = function()
            require("plugins.quick-scope") -- helps with horizontal navigation (f and t)
        end,
    })
    use({
        "ThePrimeagen/harpoon",
        config = function()
            require("plugins.harpoon")
        end,
    })
    use({
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_keymaps() -- vertical navigation
        end,
    })

    -- Remaps
    use("machakann/vim-sandwich") -- like vim-surround but highlights text and also supports dot command
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("plugins.autopairs") -- auto pair for (), [], {}, "" etc...
        end,
    })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.comment")
        end,
    })

    --> Appearance and GUI <--
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end,
    })                               -- git decorations
    use("kyazdani42/nvim-web-devicons") -- Required by many plugins
    -- Not using anymore since :Lspsaga rename
    -- use({
    --   "stevearc/dressing.nvim",
    --   config = function()
    --     require("plugins.dressing") -- improves vim.ui interfaces (input and select)
    --   end,
    -- })                           --> beautiful vim.ui.select and vim.ui.input
    use({
        "folke/trouble.nvim",
        config = function()
            require("plugins.trouble") -- pretty list of diagnostics
        end,
    })                        --> pretty list of LSP diagnostics and references
    use({
        "rcarriga/nvim-notify",
        config = function()
            require("plugins.notify") -- improves notification interface
        end,
    })                        --> notification manager
    use("RRethy/vim-illuminate") -- highlights other uses of the word under cursor using LSP and treesitter

    -- Color themes
    use("lunarvim/darkplus.nvim")
    -- use { "catppuccin/nvim", as = "catppuccin" }
    -- use { "lewis6991/github_dark.nvim" }

    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.lualine")
        end,
    })
    -- use("mbbill/undotree")
    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("plugins.nvimtree")
        end,
    })
    use("simeji/winresizer") -- Easy resizing of vim windows (press <c-W>)
    -- use("vonr/align.nvim") -- especially used to align comments (press '<leader>al' in visual mode)

    use({
        "gbprod/yanky.nvim",
        config = function()
            require("plugins.yanky")
        end,
    })

    -- Completion
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.cmp")
        end,
    })
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua") --> completion source for nvim lua api
    use("saadparwaiz1/cmp_luasnip")

    -- Snippets
    use({
        "L3MON4D3/LuaSnip",
        config = function()
            require("plugins.luasnip-setup")
        end,
    })
    use({
        "rafamadriz/friendly-snippets",
        config = function()
            require("plugins.friendly-snippets")
        end,
    })

    -- LSP
    use({
        "neovim/nvim-lspconfig", -- provides basic configurations of LSP servers
        config = function()
            require("plugins.lsp")
        end,
    })
    use("williamboman/mason.nvim")        -- provides a repository and frontend that helps a user manage the installation of various third-party tools (LSP servers, formatters, linters)
    use("williamboman/mason-lspconfig.nvim") -- uses Mason to ensure installation of user specified LSP servers and will tell nvim-lspconfig what command to use to launch those servers (that is, it's a bridge between the 2 former plugins)
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("plugins/null-ls")
        end,
    })                       -- for formatters and linters
    use("onsails/lspkind.nvim") --> add pictograms to neovim lsp
    -- Improves neovim built-in LSP experience with a bunch of new functionalities
    -- https://nvimdev.github.io/lspsaga/
    use({
        "nvimdev/lspsaga.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("plugins.lspsaga")
        end,
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },                         -- dependency
            { "burntsushi/ripgrep" },                            -- necessary for live_grep picker
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- better sorgint performance
            { "nvim-telescope/telescope-ui-select.nvim" },       --> sets vim.ui.select to telescope
        },
        config = function()
            require("plugins.telescope")
        end,
    })

    -- Shows colorcolumn when line length exceeds threshold
    use({
        "m4xshen/smartcolumn.nvim",
        config = function()
            require("smartcolumn").setup({
                colorcolumn = "120",
            })
        end,
    })

    use({
        "james1236/backseat.nvim",
        config = function()
            require("plugins.backseat")
        end,
    })

    -- entireBuffer: gG (useful for yanking whole file)
    -- key of key-value pair, or left side of a variable assignment: ik, ak
    -- value of key-value pair, or right side of a variable assignment: iv, av
    -- number: in, an
    -- mdFencedCodeBlock: iC, aC
    use({
        "chrisgrieser/nvim-various-textobjs",
        config = function()
            require("various-textobjs").setup({ useDefaultKeymaps = true })
        end,
    })

    -- run tests
    use({
        "vim-test/vim-test",
        config = function()
            require("plugins.vim-test")
        end,
    })

    -- allow alternating between file and its corresponding test file
    -- vim-test and vim-projections integrate really well:
    -- you can run a test file from its alternate file
    use({
        "tpope/vim-projectionist",
        config = function()
            require("plugins.vim-projectionist")
        end,
    })

    -- easier macros: press q to start and stop; press Q to reproduce
    -- also has handy notifications
    use({
        "chrisgrieser/nvim-recorder",
        requires = "rcarriga/nvim-notify", -- optional
        config = function()
            require("plugins.nvim-recorder")
        end,
    })

    -- use({
    --   "https://git.amazon.com/pkg/AmazonCodeWhispererVimPlugin",
    --   name = "codewhisperer",
    --   build =
    --   [[cat ~/.local/share/nvim/lazy/codewhisperer/service-2.json | jq '.metadata += {"serviceId":"codewhisperer"}' | tee /tmp/aws-coral-model.json && aws configure add-model --service-model file:///tmp/aws-coral-model.json --service-name codewhisperer]],
    -- })
    -- use({
    --     "https://git.amazon.com/pkg/Scat-nvim",
    --     branch = "mainline",
    --     config = function()
    --         local map_key = vim.keymap.set
    --         local brazil = require("scat.brazil")
    --         local cr = require("scat.cr")
    --         local paste = require("scat.paste")
    --         local local_manager = require("scat.cr.local_manager")
    --         local brazil_utils = require("scat.brazil.utils")
    --         local scat = require("scat")
    --         scat.setup({
    --             cr = {
    --                 -- template_path = vim.fn.expandcmd"$HOME/<path_to_your_cr_template>",
    --                 -- user = "<your_user_name>"
    --             },
    --         })
    --
    --         map_key("n", "<leader>al", brazil.list_all_packages)
    --         -- map_key("n", "<leader>ap", brazil.display_current_package_url)
    --         -- map_key("n", "<leader>aP", brazil.display_package_under_cursor_url)
    --         -- map_key("n", "<leader>aR", brazil.display_release_under_cursor_url)
    --         map_key({ "n", "x" }, "<leader>af", brazil.display_current_file_url)
    --         map_key("n", "<leader>aij", brazil.install_current_jdt_package)
    --         map_key("n", "<leader>ar", cr.open_cr)
    --         -- or map_key("n", "<leader>ar", function() cr.open_cr({ cr_template = vim.fn.expandcmd"$HOME/<path_to_your_cr_template>" }) end)
    --         map_key("n", "<leader>arp", cr.fetch_active_crs)
    --         -- or map_key("n", "<leader>arp", function() cr.fetch_active_crs({user = "<your_user_name>"}) end)
    --         map_key("n", "<leader>aru", cr.update_existing_cr)
    --         map_key("n", "<leader>art", local_manager.toggle_cr_overview)
    --         map_key("n", "<leader>ac", brazil_utils.run_checkstyle)
    --         map_key("n", "<leader>ab", brazil.build_current_package)
    --         map_key("n", "<leader>abc", brazil.run_command_inside_current_package)
    --         map_key("n", "<leader>abt", function()
    --             brazil.pick_brazil_task_inside_current_package({
    --                 callback = function(task)
    --                     vim.g.test_replacement_command = task
    --                 end,
    --             })
    --         end)
    --         map_key("n", "<leader>abl", brazil.run_prev_brazil_task)
    --         map_key("n", "<leader>av", brazil.display_current_version_set_url)
    --         map_key("n", "<leader>abr", brazil.build_current_package_recursively)
    --         map_key("n", "<leader>ais", brazil.lookup_packages)
    --         map_key("n", "<leader>aiv", brazil.lookup_version_set)
    --         map_key("n", "<leader>aw", brazil.switch_workspace_package_info)
    --         map_key({ "n", "x" }, "<leader>as", paste.send_to_pastebin)
    --         map_key("n", "<leader>asl", paste.list_my_pastes)
    --         -- if you are using the patched fork of Telescope, you can also leverage these, see more details below
    --         -- map_key('n', '<leader>ais', brazil.lookup_packages)
    --         -- map_key('n', '<leader>aiv', brazil.lookup_version_set)
    --     end,
    --     requires = { "nvim-telescope/telescope.nvim", "sindrets/diffview.nvim" },
    -- })
    -- use({
    --     "https://git.amazon.com/pkg/Scat-nvim",
    --     branch = "mainline",
    --     config = function()
    --         local map_key = vim.keymap.set
    --         local brazil = require("scat.brazil")
    --         local cr = require("scat.cr")
    --         local paste = require("scat.paste")
    --         local local_manager = require("scat.cr.local_manager")
    --         local brazil_utils = require("scat.brazil.utils")
    --         local scat = require("scat")
    --         scat.setup({
    --             cr = {
    --                 -- template_path = vim.fn.expandcmd"$HOME/<path_to_your_cr_template>",
    --                 -- user = "<your_user_name>"
    --             },
    --         })
    --
    --         map_key("n", "<leader>al", brazil.list_all_packages)
    --         -- map_key("n", "<leader>ap", brazil.display_current_package_url)
    --         -- map_key("n", "<leader>aP", brazil.display_package_under_cursor_url)
    --         -- map_key("n", "<leader>aR", brazil.display_release_under_cursor_url)
    --         map_key({ "n", "x" }, "<leader>af", brazil.display_current_file_url)
    --         -- map_key("n", "<leader>aij", brazil.install_current_jdt_package)
    --         -- map_key("n", "<leader>ar", cr.open_cr)
    --         -- or map_key("n", "<leader>ar", function() cr.open_cr({ cr_template = vim.fn.expandcmd"$HOME/<path_to_your_cr_template>" }) end)
    --         -- map_key("n", "<leader>arp", cr.fetch_active_crs)
    --         -- or map_key("n", "<leader>arp", function() cr.fetch_active_crs({user = "<your_user_name>"}) end)
    --         -- map_key("n", "<leader>aru", cr.update_existing_cr)
    --         -- map_key("n", "<leader>art", local_manager.toggle_cr_overview)
    --         map_key("n", "<leader>ac", brazil_utils.run_checkstyle)
    --         map_key("n", "<leader>ab", brazil.build_current_package)
    --         map_key("n", "<leader>abc", brazil.run_command_inside_current_package)
    --         -- map_key("n", "<leader>abt", function()
    --         --     brazil.pick_brazil_task_inside_current_package({
    --         --         callback = function(task)
    --         --             vim.g.test_replacement_command = task
    --         --         end,
    --         --     })
    --         -- end)
    --         -- map_key("n", "<leader>abl", brazil.run_prev_brazil_task)
    --         -- map_key("n", "<leader>av", brazil.display_current_version_set_url)
    --         map_key("n", "<leader>abr", brazil.build_current_package_recursively)
    --         -- map_key("n", "<leader>ais", brazil.lookup_packages)
    --         -- map_key("n", "<leader>aiv", brazil.lookup_version_set)
    --         -- map_key("n", "<leader>aw", brazil.switch_workspace_package_info)
    --         -- map_key({ "n", "x" }, "<leader>as", paste.send_to_pastebin)
    --         -- map_key("n", "<leader>asl", paste.list_my_pastes)
    --         -- if you are using the patched fork of Telescope, you can also leverage these, see more details below
    --         -- map_key('n', '<leader>ais', brazil.lookup_packages)
    --         -- map_key('n', '<leader>aiv', brazil.lookup_version_set)
    --     end,
    --     requires = { "nvim-telescope/telescope.nvim", "sindrets/diffview.nvim" },
    -- })
end)
