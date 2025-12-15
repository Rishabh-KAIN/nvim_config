local options = {
	ensure_installed = {
		"bash",
		-- "c",
		-- "cmake",
		-- "cpp",
		"fish",
		"go",
		"gomod",
		"gosum",
		"gotmpl",
		"gowork",
		-- "haskell",
		"lua",
		"luadoc",
		"make",
		"markdown",
		-- "odin",
		"printf",
		"python",
		"toml",
		"vim",
		"vimdoc",
		"yaml",
		"javascript",
		"typescript",
		"tsx",
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},
	diagnostics = {
		enable = true,
		show_on_directories = true,
	},
	indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
