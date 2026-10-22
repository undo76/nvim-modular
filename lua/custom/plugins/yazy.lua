local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'mikavilpas/yazi.nvim' }

-- Next, map a key to open yazi.nvim
vim.keymap.set('n', '<leader>y', function() require('yazi').yazi() end, { desc = 'Open Yazy' })

-- 👇 if you use `open_for_directories=true`, this is recommended.
--
-- mark netrw as loaded so it's not loaded at all.
-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
vim.g.loaded_netrwPlugin = 1
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    require('yazi').setup {
      open_for_directories = true,
    }
  end,
})
