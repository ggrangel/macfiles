vim.cmd([[
let test#javascript#jest#executable = "./node_modules/.bin/jest"
let test#neovim#term_position = "vert"
let test#strategy = "neovim"
let g:test#echo_command = 0
if has('nvim')
  tmap <C-o> <C-\><C-n> " C-o goes from TERMINAL INSERT mode to NORMAL mode
endif
]])
