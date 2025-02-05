return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = '<leader>T',
    }
    vim.api.nvim_set_keymap('n', '<S-CR>', ':TermExec cmd="⏎"<CR>', { desc = 'Send new line to terminal', noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<Leader>T ', ':TermSelect<cr>', { desc = 'Open terminal', noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<Leader>Tf', ':ToggleTerm direction=float<cr>', { desc = 'Open terminal', noremap = true, silent = true })
    -- vim.api.nvim_set_keymap(
    --   'n',
    --   '<Leader>Tl',
    --   ':TermExec size=10 direction=horizontal name=comopose-log cmd="aws-vault exec sandbox -- docker compose logs -f"<cr>',
    --   { desc = 'payprop logs', noremap = true, silent = true }
    -- )
    -- vim.api.nvim_set_keymap(
    --   'n',
    --   '<Leader>Tu',
    --   ':TermExec size=10 direction=horizontal name=compose-up cmd="aws-vault exec sandbox -- docker compose up"<cr>',
    --   { desc = 'payprop logs', noremap = true, silent = true }
    -- )
    -- vim.api.nvim_set_keymap(
    --   'n',
    --   '<Leader>Tpl',
    --   ':TermExec size=10 direction=horizontal name=pplog cmd="pp-compose logs -f"<cr>',
    --   { desc = 'payprop logs', noremap = true, silent = true }
    -- )
    -- vim.api.nvim_set_keymap(
    --   'n',
    --   '<Leader>Tm',
    --   ':TermExec width=20 direction=float name=ppmenu cmd="ppmenu"<cr>',
    --   { desc = 'ppmenu', noremap = true, silent = true }
    -- )
  end,
}
