return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {}
    vim.keymap.set('n', '<leader>sp', ':Telescope projects<CR>', { desc = '[S]earch [P]roject', noremap = true })
  end,
}
