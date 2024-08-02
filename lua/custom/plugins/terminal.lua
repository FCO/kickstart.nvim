return {
  'voldikss/vim-floaterm',
  config = function()
    print 'loading floaterm'
    vim.api.nvim_set_keymap('v', '<Leader>T', ':FloatermNew<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>Tt', ':FloatermToggle<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>Tp', ':FloatermNew! pp-compose logs -f<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>Tm', ':FloatermNew! --height=0.9 ppmenu<cr>', { noremap = true, silent = true })
  end,
}
