-- vim.cmd([[
-- try
--   colorscheme darkplus
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]])

vim.cmd([[colorscheme tokyonight-night]])

-- local flavour = "mocha"
--
-- -- less contrast for evenings
-- if os.date("*t").hour >= 18 then
--   flavour = "macchiato"
-- end
--
-- vim.g.catppuccin_flavour = flavour
-- vim.cmd [[colorscheme catppuccin]]
