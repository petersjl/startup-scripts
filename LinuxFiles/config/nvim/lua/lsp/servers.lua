-- add language servers here for syntax highlighting
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' }
				}
			}
		}
	},
}

return servers
