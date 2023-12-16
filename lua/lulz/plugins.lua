local fn = vim.fn


-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("error loading Packer", "error")
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

	use({
		"andweeb/presence.nvim",
		config = function()
			require("presence").setup({
				neovim_image_text = "I use vim btw",
				editing_text = "%s",
				main_image = "file",
				file_explorer_text = "browsing files",
				workspace_text = "%s",
			})
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- cmp
	use({
		"hrsh7th/nvim-cmp", -- The completion plugin
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		"hrsh7th/cmp-cmdline", -- cmdline completions
		"saadparwaiz1/cmp_luasnip", -- snippet completions
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",

		-- snippets
		"L3MON4D3/LuaSnip", --snippet engine
		"rafamadriz/friendly-snippets", -- a bunch of snippets to use
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig", -- enable LSP
		"williamboman/mason.nvim", -- simple to use language server installer
		"williamboman/mason-lspconfig.nvim", -- simple to use language server installer
		"jose-elias-alvarez/null-ls.nvim", -- LSP diagnostics and code actions
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- colorschemes
	use({
		"EdenEast/nightfox.nvim",
		"KabbAmine/yowish.vim",
		{ "catppuccin/nvim", as = "catppuccin" },
		{ "Shatur/neovim-ayu" },
		{
			"ellisonleao/gruvbox.nvim",
			config = function()
				require("gruvbox").setup({
					contrast = "hard",
					-- transparent = true,
				})
			end,
		},
		"FrenzyExists/aquarium-vim",
		{ "rose-pine/neovim", as = "rose-pine" },
    'folke/tokyonight.nvim',
    "myagko/nymph.nvim", 
    "josephwecker/murphytango.vim",
    "miikanissi/modus-themes.nvim", 
    "craftzdog/solarized-osaka.nvim",
    'rafamadriz/neon', 
    'rockerBOO/boo-colorscheme-nvim',
    'ray-x/aurora',
    'kvrohit/rasmus.nvim',
    'kvrohit/mellow.nvim', 
    'sainnhe/everforest', 
	})

	use({
		"windwp/nvim-ts-autotag",
	})

  use("windwp/nvim-autopairs")

	use("ThePrimeagen/vim-be-good")

	-- Flutter
	use({
		"dart-lang/dart-vim-plugin",
		"thosakwe/vim-flutter",
		"natebosch/vim-lsc",
		"natebosch/vim-lsc-dart",
		"natebosch/dartlang-snippets",
	})

	-- Toggleterm
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				direction = "float",
			})
		end,
	})

  -- Transparency
  use('xiyaowong/transparent.nvim')

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
