return {
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
  {
    'tzachar/cmp-ai',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local cmp_ai = require 'cmp_ai.config'

      cmp_ai:setup {
        max_lines = 100,
        provider = 'Ollama',
        provider_options = {
          model = 'codellama',
        },
        notify = true,
        notify_callback = function(msg)
          vim.notify(msg)
        end,
        run_on_every_keystroke = true,
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
      }
    end,
  },
}
