local nvim_folder = os.getenv("MYVIMRC") .. "/.." 
require("luasnip.loaders.from_lua").load({paths = nvim_folder .. "/lua/snippets"})
