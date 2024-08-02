----height=0.6--height=0.6 You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.api.nvim_set_keymap('n', ']b', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[b', ':bprev<CR>', { noremap = true, silent = true })
return {
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
  { 'jeetsukumaran/vim-indentwise' },
  { 'aklt/plantuml-syntax' },
  { 'vim-perl/vim-perl' },
  { 'junegunn/vim-easy-align', keys = { 'ga' } },
  { 'mracos/mermaid.vim' },
  { 'tpope/vim-dadbod' },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  'nvim-tree/nvim-web-devicons',
  'google/vim-jsonnet',
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
      {
        'akinsho/org-bullets.nvim',
        config = function()
          require('org-bullets').setup()
        end,
      },
      {
        'lukas-reineke/headlines.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = true, -- or `opts = {}`
      },
      {
        'michaelb/sniprun',
        branch = 'master',

        build = 'sh install.sh',
        -- do 'sh install.sh 1' if you want to force compile locally
        -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

        config = function()
          vim.o.conceallevel = 2
          vim.g.org_conceal = 1
          require('sniprun').setup {
            -- your options
          }
        end,
      },
      { 'dhruvasagar/vim-table-mode' },
    },
    event = 'VeryLazy',
    config = function()
      -- Load treesitter grammar for org
      -- require("orgmode").setup_ts_grammar()

      -- Setup treesitter
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
        },
        ensure_installed = { 'org' },
      }

      -- Setup orgmode
      require('orgmode').setup {
        org_agenda_files = '~/org/**/*',
        org_default_notes_file = '~/org/refile.org',
        win_split_mode = 'float',
      }
    end,
  },
  {
    'chipsenkbeil/org-roam.nvim',
    lazy = false,
    tag = '0.1.0',
    dependencies = {
      {
        'nvim-orgmode/orgmode',
        -- tag = "0.3.4",
      },
      {
        'akinsho/org-bullets.nvim',
      },
    },
    config = function()
      require('org-roam').setup {
        directory = '~/org-roam',
        -- optional
        org_files = {
          '~/org/*.org',
        },
      }
    end,
  },
  {
    'karb94/neoscroll.nvim',
    lazy = false,
    opts = {},
  },
  {
    'nvim-orgmode/telescope-orgmode.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-orgmode/orgmode',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('telescope').load_extension 'orgmode'

      vim.keymap.set('n', '<leader>r', require('telescope').extensions.orgmode.refile_heading)
      vim.keymap.set('n', '<leader>fh', require('telescope').extensions.orgmode.search_headings)
      vim.keymap.set('n', '<leader>li', require('telescope').extensions.orgmode.insert_link)
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- Optional
      {
        'stevearc/dressing.nvim', -- Optional: Improves the default Neovim UI
        opts = {},
      },
    },
    config = function()
      require('codecompanion').setup {
        adapters = {
          anthropic = require('codecompanion.adapters').use 'anthropic',
          ollama = require('codecompanion.adapters').use('ollama', {
            schema = {
              model = {
                default = 'codellama',
              },
            },
          }),
          openai = require('codecompanion.adapters').use 'openai',
        },
        strategies = {
          chat = {
            adapter = 'ollama',
          },
          inline = {
            adapter = 'ollama',
          },
          agent = {
            adapter = 'ollama',
          },
        },
      }
      -- Write a function
      vim.api.nvim_set_keymap('n', '<Leader>cc', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<Leader>cc', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>cct', '<cmd>CodeCompanionToggle<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<Leader>cct', '<cmd>CodeCompanionToggle<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', 'ga', '<cmd>CodeCompanionAdd<cr>', { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]
    end,
  },
  {
    'David-Kunz/gen.nvim',
    opts = {
      model = 'codellama',
    },
  },
  { 'olacin/telescope-cc.nvim' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      tabline = {
        lualine_a = { 'buffers' },
        -- lualine_b = { 'branch' },
        -- lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' },
      },
    },
  },
  {
    'voldikss/vim-floaterm',
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>tt', ':FloatermToggle<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<Leader>t', ':FloatermNew<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>tpp', ':FloatermNew! pp-compose logs -f<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>tpm', ':FloatermNew! --height=0.9 ppmenu<cr>', { noremap = true, silent = true })
    end,
  },
  { 'tpope/vim-fugitive' },
}
