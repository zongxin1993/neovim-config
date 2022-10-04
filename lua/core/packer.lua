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
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
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

  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "akinsho/bufferline.nvim" })
  use({ "moll/vim-bbye" })
  use({ "nvim-lualine/lualine.nvim" })
  use({ "akinsho/toggleterm.nvim" })
  use({ "ahmedkhalf/project.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "goolord/alpha-nvim" })
  use("folke/which-key.nvim")

  -- Colorschemes
  use({ "folke/tokyonight.nvim" })
  use("lunarvim/darkplus.nvim")

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  use({ "hrsh7th/cmp-path" }) -- path completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })

  -- snippets
  use({ "L3MON4D3/LuaSnip" }) --snippet engine
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  -- Marks
  use "christianchiarulli/harpoon"
  use "MattesGroeger/vim-bookmarks"

  -- LSP
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
  use({
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require "plugin.copilot"
      end, 100)
    end,
  })
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })
  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
  })

  -- Git
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

  -- Notify
  use({
    "rcarriga/nvim-notify",
    config = function()
      require("core.notify").setup()
    end,
    requires = { "nvim-telescope/telescope.nvim" },
  })

  -- Git diff
  use({ "sindrets/diffview.nvim", require = "nvim-lua/plenary.nvim" })

  -- Outline
  use({
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  })

  -- Comments
  use({
    "numToStr/Comment.nvim",
  })

  use({
    "glepnir/galaxyline.nvim",
  })
  use({ "SmiteshP/nvim-gps" })
  -- debugger
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("theHamsta/nvim-dap-virtual-text")

  -- use({"wesleimp/stylua.nvim"})
  use({ "yamatsum/nvim-cursorline" })

  use({ "norcalli/nvim-colorizer.lua" })

  use({ "npxbr/glow.nvim", cmd = "Glow", run = ":GlowInstall" })

  use({ "j-hui/fidget.nvim", ft = enable_lsp_filetype,
    config = function()
      require("fidget").setup {}
    end
  })
  use({ "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup(
        {
          bind = true,
          handler_opts = {
            border = "rounded"
          },
          hint_enable = false,
          floating_window = true,
          hi_parameter = "LspSignatureActiveParameter"
        }
      )
    end
  })
  use({ "antoinemadec/FixCursorHold.nvim" })
  -- Theme
  use {
    "glepnir/zephyr-nvim",
    requires = { "nvim-treesitter/nvim-treesitter", opt = true },
    config = function()
      require("zephyr")
    end
  }
  use("windwp/nvim-spectre")
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
