require("nvchad.options")

local o = vim.o

-- Indenting
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

o.foldmethod = "expr"
o.foldcolumn = "1"
o.foldenable = false
o.foldlevel = 99
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

o.colorcolumn = "100"
-- o.cursorlineopt = "both" -- to enable cursorline!

-- set filetype for .CBL COBOL files.
-- vim.cmd([[ au BufRead,BufNewFile *.CBL set filetype=cobol ]])
