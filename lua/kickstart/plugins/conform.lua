local function gh(repo) return 'https://github.com/' .. repo end

local use_prettier = { 'prettierd', 'prettier', stop_after_first = true, lsp_format = 'never' }

-- [[ Formatting ]]
vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = { timeout_ms = 500 },
  -- format_on_save = function(bufnr)
  --   -- You can specify filetypes to autoformat on save here:
  --   local enabled_filetypes = {
  --     lua = true,
  --     python = true,
  --   }
  --   if enabled_filetypes[vim.bo[bufnr].filetype] then
  --     return { timeout_ms = 500 }
  --   else
  --     return nil
  --   end
  -- end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    rust = { 'rustfmt' },
    -- Conform can also run multiple formatters sequentially
    -- You can use 'stop_after_first' to run the first available formatter from the list
    javascript = use_prettier,
    javascriptreact = use_prettier,
    typescript = use_prettier,
    vue = use_prettier,
    css = use_prettier,
    scss = use_prettier,
    html = use_prettier,
    json = use_prettier,
    jsonc = use_prettier,
    yaml = use_prettier,
    markdown = use_prettier,

    python = {
      'ruff_organize_imports',
      'ruff_format',
      lsp_format = 'never',
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })

-- vim: ts=2 sts=2 sw=2 et
