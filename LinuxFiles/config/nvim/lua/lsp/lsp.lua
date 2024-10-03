local lspconfig = require("lspconfig")
local servers = require("lsp/servers")
for lsp,opts in pairs(servers) do
	lspconfig[lsp].setup(opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<Leader>R", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<Leader>i", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<Leader>P", function()
      vim.lsp.buf.format { async = true }
    end, opts)


		vim.opt.formatoptions:remove("o")

  end,
})
