local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'preservim/nerdtree'
--	use 'mattn/emmet-vim'
--	use 'pangloss/vim-javascript'
--	use 'mxw/vim-jsx'
	use 'machakann/vim-highlightedyank'
	use 'tpope/vim-commentary'
	use 'frazrepo/vim-rainbow'
	use 'tpope/vim-surround'
	use 'vim-scripts/ReplaceWithRegister'
	use { "catppuccin/nvim", as = "catppuccin" }
--	use 'stevearc/oil.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
