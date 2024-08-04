return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- signs = {
      --   add = { text = '+' },
      --   change = { text = '~' },
      --   delete = { text = '_' },
      --   topdelete = { text = '‾' },
      --   changedelete = { text = '~' },
      -- },
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = function()
      require('neogit').setup {}
      vim.keymap.set('n', '<leader>hh', ':Neogit<CR>', { desc = 'Neogit', noremap = true, silent = true })
    end,
  },
  -- {
  --   'davidsierradz/cmp-conventionalcommits',
  --   -- config = function()
  --   --   -- GAMBIARRA
  --   --   local source = require 'cmp-conventionalcommits'
  --   --   function source:is_available()
  --   --     return vim.list_contains({ 'gitcommit', 'NeogitCommitMessage' }, 'gitcommit')
  --   --   end
  --   -- end,
  -- },
}
