-- https://github.com/crispgm/nvim-tabline
return {
	"crispgm/nvim-tabline",
    event="VeryLazy",
    enabled=true,
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
	config = {
		show_icon = true,
		brackets = { "", "" },
		fnamemodify = ":t", -- file name modifier string.Can be a function to modify buffer name
		modify_indicator = " ●",
	},
}
