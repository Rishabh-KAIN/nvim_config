local options = {
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Git Next Hunk" })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Git Prev Hunk" })
		-- -----------------------------------------------------------------------
		-- ACTIONS
		-- -----------------------------------------------------------------------
		map("n", "<leader>gs", gs.stage_hunk, { desc = "Git Stage Hunk" })
		map("n", "<leader>gr", gs.reset_hunk, { desc = "Git Reset Hunk" })
		map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Git Undo Stage Hunk" })
		map("n", "<leader>gp", gs.preview_hunk, { desc = "Git Preview Hunk" })
		map("n", "<leader>gb", function()
			gs.blame_line({ full = true })
		end, { desc = "Git Blame Line" })
		local gs_config = require("gitsigns.config").config
		map("n", "<leader>gd", function()
			if not vim.wo.diff then
				gs.diffthis()
				if not gs_config.word_diff then
					gs.toggle_word_diff()
				end
			else
				vim.cmd("diffoff")
				if gs_config.word_diff then
					gs.toggle_word_diff()
				end
				-- I don't understand the following for and if condition but it works :)
				local wins = vim.api.nvim_tabpage_list_wins(0)
				for _, win in ipairs(wins) do
					local buf = vim.api.nvim_win_get_buf(win)
					local name = vim.api.nvim_buf_get_name(buf)

					if name:match("^gitsigns://") then
						vim.api.nvim_win_close(win, true)
					end
				end
			end
		end, { desc = "Toggle Git Diff Split" })
		-- -----------------------------------------------------------------------
		-- TEXT OBJECTS (For selecting)
		-- -----------------------------------------------------------------------
		-- Allows you to type "vih" (visual inner hunk) to select a change block
		map({ "o", "x" }, "gh", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git select hunk" })
		map("n", "<leader>gi", function()
			gs.toggle_linehl()
			gs.toggle_deleted()
			gs.toggle_word_diff()
		end, { desc = "Toggle Git Inline Diff" })
	end,
}
require("gitsigns").setup(options)
