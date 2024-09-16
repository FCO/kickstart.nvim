return {
  'mistweaverco/kulala.nvim',
  config = function()
    -- Define an autocmd to set the filetype to http for .http and .rest files
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      pattern = { '*.http', '*.rest' },
      callback = function()
        vim.bo.filetype = 'http'
      end,
    })
    require('kulala').setup {}
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'http',
      callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader><CR>', ':lua require("kulala").run()<CR>', { desc = 'Run HTTP request' })
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>y', ':lua require("kulala").copy()<CR>', { desc = 'Copy HTTP request' })
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>C', ':lua require("kulala").close()<CR>', { desc = 'Close butter and window' })
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>t', ':lua require("kulala").toggle_view()<CR>', { desc = 'Toggle header and body' })
        vim.api.nvim_buf_set_keymap(0, 'n', '[h', ':lua require("kulala").jump_prev()<CR>', { desc = 'Jump previous request' })
        vim.api.nvim_buf_set_keymap(0, 'n', ']h', ':lua require("kulala").jump_next()<CR>', { desc = 'Jump next request' })
      end,
    })
  end,
}
