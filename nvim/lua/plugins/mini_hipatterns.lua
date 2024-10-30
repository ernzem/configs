local enable_hex_color_highlight = true
local cfg = {
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
	},
}

return {
	"echasnovski/mini.hipatterns",
	version = false,
	event = "VeryLazy",
	opts = false,
	config = function()
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup(cfg)

		local hex_highlight_toggle = function()
			local buf_nr = vim.api.nvim_get_current_buf()
			hipatterns.disable(buf_nr)

			if enable_hex_color_highlight then
				enable_hex_color_highlight = false
                cfg.highlighters.hex_color = hipatterns.gen_highlighter.hex_color()
            else
                enable_hex_color_highlight = true
                cfg.highlighters.hex_color = {}
			end

			return hipatterns.enable(buf_nr, cfg)
		end

		vim.keymap.set("n", "<leader>th", hex_highlight_toggle, { desc = "Toggle Hex color highlihgting" })
	end,
}
