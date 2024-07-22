-- Install Lazy.nvim automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- After installation, run `checkhealth lazy` to see if everything goes right
-- Hints:
--     build: It will be executed when a plugin is installed or updated
--     config: It will be executed when the plugin loads
--     event: Lazy-load on event
--     dependencies: A list of plugin names or plugin specs that should be loaded when the plugin loads
--     ft: Lazy-load on filetype
--     cmd: Lazy-load on command
--     init: Functions are always executed during startup
--     opts: The table will be passed to the require(...).setup(opts)
require("lazy").setup({
	-- LSP manager
  "LunarVim/bigfile.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
  {
      "puremourning/vimspector",
      event = "InsertEnter",
      keys = {"j", "h", "k", "l"}
  },
  -- "tpope/vim-obsession",
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave" }, -- optional for lazy loading on trigger events
    opts = {
        enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
        execution_message = {
            enabled = false,
        },
    }
  },
	-- Add hooks to LSP to support Linter && Formatter
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			-- Note:
			--     the default search path for `require` is ~/.config/nvim/lua
			--     use a `.` as a path seperator
			--     the suffix `.lua` is not needed
			require("config.mason-null-ls")
		end,
	},
	-- Vscode-like pictograms
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
	},
	-- Auto-completion engine
	{
		"hrsh7th/nvim-cmp",
        event = "InsertEnter",
        keys = {"j", "h", "k", "l"},
		dependencies = {
            "lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
		config = function()
			require("config.nvim-cmp")
		end,
	},
	-- Code snippet engine
	{
		"L3MON4D3/LuaSnip",
        ft = { "lua" },
		version = "v2.*",
	},
	-- Colorscheme
	"tanvirtin/monokai.nvim",
	{
      "Mofiqul/vscode.nvim",
      -- opts = { style = 'light' },
  },
  {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
          winopts = {
            height           = 0.95,            -- window height
            width            = 0.95,            -- window width
            row              = 0.35,            -- window row position (0=top, 1=bottom)
            col              = 0.50,            -- window col position (0=left, 1=right)
          },
        })
      end
  },
  {
      "rcarriga/nvim-notify",
      opts = {
          background_colour = "NotifyBackground",
          fps = 60,
          icons = {
            DEBUG = "",
            ERROR = "",
            INFO = "",
            TRACE = "✎",
            WARN = ""
          },
          level = 2,
          minimum_width = 30,
          render = "compact",
          stages = "fade",
          time_formats = {
            notification = "%T",
            notification_history = "%FT%T"
          },
          timeout = 1000,
          top_down = true
      }
  },
	-- Better UI
    -- Run `:checkhealth noice` to check for common issues
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
		},
	},
	-- Git integration
	"tpope/vim-fugitive",
	-- Git decorations
	{
		"lewis6991/gitsigns.nvim",
        event = "InsertEnter",
        keys = {"j", "h", "k", "l"},
		config = function()
			require("config.gitsigns")
		end,
	},
	-- Autopairs: [], (), "", '', etc
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("config.nvim-autopairs")
		end,
	},
	-- Code comment helper
	--     1. `gcc` to comment a line
	--     2. select lines in visual mode and run `gc` to comment/uncomment lines
	"tpope/vim-commentary",
	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		config = function()
			require("config.nvim-tree")
		end,
	},
	-- Treesitter-integration
	{
		"nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
		build = ":TSUpdate",
		config = function()
			require("config.nvim-treesitter")
		end,
	},
	-- Nvim-treesitter text objects
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.nvim-treesitter-textobjects")
		end,
	},
	-- Show indentation and blankline
	{
		"lukas-reineke/indent-blankline.nvim",
        event = "InsertEnter",
        keys = {"j", "h", "k", "l"},
		config = function()
			require("config.indent-blankline")
		end,
	},
	-- Status line
	{
		"nvim-lualine/lualine.nvim",
        ft = { "lua" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.lualine")
		end,
	},
	-- Markdown support
	{ "preservim/vim-markdown", ft = { "markdown" } },
	-- Markdown previewer
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- Smart motion
	-- Usage: Enter 2-character search pattern then press a label character to
	--        pick your target.
	--        Initiate the sesarch with `s`(forward) or `S`(backward)
	{
		"ggandor/leap.nvim",
		config = function()
			-- See `:h leap-custom-mappings` for more details
			require("leap").create_default_mappings()
            require('leap').opts.safe_labels = {}
            vim.keymap.set({'n', 'v', 'o'}, 's', function ()
              require('leap').leap {
                target_windows = require('leap.user').get_focusable_windows()
              }
            end)
		end,
	},
	-- Better terminal integration, <C-\> to toggle
	{
		"akinsho/toggleterm.nvim",
        event = "InsertEnter",
        keys = {"j", "h", "k", "l"},
		version = "*",
		config = function()
			require("config.toggleterm")
		end,
	},
	-- Fuzzy finder
	{

		"nvim-telescope/telescope.nvim",
        event = "InsertEnter",
        keys = {"j", "h", "k", "l"},
		branch = "0.1.x",
		dependencies = {
      {"nvim-lua/plenary.nvim"},
      {
          "nvim-telescope/telescope-live-grep-args.nvim" ,
          version = "^1.0.0",
      },
    },
		config = function()
			require("config.telescope")
		end,
	}
})
