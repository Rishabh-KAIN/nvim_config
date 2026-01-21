dofile(vim.g.base46_cache .. "nvimtree")
vim.cmd([[
    :hi NvimTreeGitDirty guifg=#bb9931
    :hi NvimTreeGitNew guifg=#22bb65
    :hi NvimTreeGitDeleted guifg=#bb3131
]])
return {
	filters = { dotfiles = false },
	git = { enable = true, ignore = false },
	disable_netrw = true,
	hijack_cursor = true,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	view = {
		width = 30,
		preserve_window_proportions = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
		debounce_delay = 50,
		icons = {
			hint = "󰌵",
			info = "󰋼",
			warning = "󰀦",
			error = "󰅙",
		},
	},
	renderer = {
		root_folder_label = false,
		highlight_git = true,
		indent_markers = { enable = true },
		icons = {
			show = {
				git = false,
			},
			glyphs = {
				default = "󰈚",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
				},
				git = { unmerged = "" },
			},
		},
	},
}
