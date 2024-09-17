vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('conventional_commits_form', { clear = true }),
  pattern = 'gitcommit',
  callback = function()
    vim.ui.select({
      'feat',
      'fix',
      'docs',
      'style',
      'refactor',
      'perf',
      'test',
      'chore',
    }, { prompt = 'Change type' }, function(type)
      vim.ui.input({ prompt = 'Context' }, function(context)
        local commit_message = type
        if context ~= '' then
          commit_message = commit_message .. '(' .. context .. ')'
        end
        commit_message = commit_message .. ': '
        vim.api.nvim_buf_set_text(0, 0, 0, 0, 0, { commit_message })
        vim.api.nvim_feedkeys('A', 'n', true)
      end)
    end)
  end,
})

return {}
