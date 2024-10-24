return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    local wk = require 'which-key'
    wk.setup()

    -- Document existing key chains
    if wk.add then
      wk.add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>o', group = '[N]org-mode' },
        { '<leader>n', group = '[N]org-roam' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>T', group = '[T]erminal' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end
  end,
}
