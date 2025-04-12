return {
	"crispgm/nvim-tabline",
    event="VeryLazy",
    enabled=true,
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
	config = {
		show_icon = true,
        brackets = { ' ', '' },
        modify_indicator = ' ●'

	},
}
