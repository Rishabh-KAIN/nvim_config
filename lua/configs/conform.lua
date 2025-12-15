local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		-- c = { "clang-format" },
		-- cpp = { "clang-format" },
		go = { "gofumpt", "goimports", "golines" },
		-- haskell = { "fourmolu", "stylish-haskell" },
		python = { "isort", "black" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
	},

	formatters = {
		-- -- C & C++
		-- ["clang-format"] = {
		--     prepend_args = {
		--         "-style={ \
		--                 IndentWidth: 4, \
		--                 TabWidth: 4, \
		--                 UseTab: Never, \
		--                 AccessModifierOffset: 0, \
		--                 IndentAccessModifiers: true, \
		--                 PackConstructorInitializers: Never}",
		--     },
		-- },
		-- Golang
		goimports = {
			prepend_args = { "-format" },
		},
		golines = {
			prepend_args = { "--max-len=80" },
		},
		prettier = {
			prepend_args = { "--tab-width", "4", "--use-tabs", "true", "--line-length", "80" },
		},
		-- Lua
		-- stylua = {
		--     prepend_args = {
		--         "--column-width", "80",
		--         "--line-endings", "Unix",
		--         "--indent-type", "Spaces",
		--         "--indent-width", "4",
		--         "--quote-style", "AutoPreferDouble",
		--     },
		-- },
		-- Python
		black = {
			prepend_args = {
				"--fast",
				"--line-length",
				"80",
			},
		},
		isort = {
			prepend_args = {
				"--profile",
				"black",
			},
		},
	},

	format_on_save = function(bufnr)
		if not vim.g.enable_autoformat and not vim.b[bufnr].enable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_fallback = true }
	end,
}

require("conform").setup(options)

vim.g.enable_autoformat = false

local toggle_format = function()
	vim.g.enable_autoformat = not vim.g.enable_autoformat
	print("Autoformat-on-save is now " .. (vim.g.enable_autoformat and "ENABLED" or "DISABLED"))
end

local toggle_format_buf = function()
	if vim.g.enable_autoformat then
		print(
			"Ignoring as Autoformat-on-save is enabled globally hence changing the buffer setting won't have any impact"
		)
		return
	end
	vim.b.enable_autoformat = not vim.b.enable_autoformat
	print(
		"Autoformat-on-save for this buffer is now "
			.. (vim.b.enable_autoformat and "ENABLED" or "DISABLED")
	)
end

vim.api.nvim_create_user_command("FormatToggle", toggle_format, {
	desc = "Toggle autoformat-on-save",
})

vim.api.nvim_create_user_command("FormatToggleBuffer", toggle_format_buf, {
	desc = "Enable autoformat for current buffer",
})

vim.keymap.set("n", "<leader>tf", toggle_format, { desc = "Toggle Format on Save for Session" })
vim.keymap.set("n", "<leader>tb", toggle_format_buf, { desc = "Toggle Format on Save for Buffer" })
