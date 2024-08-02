return {
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
        -- (instead of fetching a binary from the github release). requires rust >= 1.65

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
    event = 'verylazy',
    config = function()
      -- load treesitter grammar for org
      -- require("orgmode").setup_ts_grammar()

      -- setup treesitter
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
        },
        ensure_installed = { 'org' },
      }

      -- setup orgmode
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
}
