-- CodeCompanion uses Pi's tools and the local model already registered in Pi.
local gh = function(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  { src = gh 'olimorris/codecompanion.nvim', version = 'v20.0.1' },
}

local pi_model = 'omlx/Qwen3.6-35B-A3B-8bit'

require('codecompanion').setup {
  interactions = {
    chat = { adapter = { name = 'pi', model = pi_model } },
    inline = { adapter = { name = 'pi', model = pi_model } },
  },
  adapters = {
    acp = {
      pi = function()
        local helpers = require 'codecompanion.adapters.acp.helpers'
        return {
          name = 'pi',
          formatted_name = 'Pi (oMLX)',
          type = 'acp',
          roles = { llm = 'assistant', user = 'user' },
          opts = { vision = false },
          commands = {
            default = {
              vim.fn.exepath 'node',
              vim.fn.stdpath 'data' .. '/pi-acp/node_modules/pi-acp/dist/index.js',
            },
          },
          env = { PI_ACP_PI_COMMAND = vim.fn.exepath 'pi' },
          defaults = { mcpServers = {}, timeout = 60000 },
          parameters = {
            protocolVersion = 1,
            clientCapabilities = { fs = { readTextFile = true, writeTextFile = true } },
            clientInfo = { name = 'CodeCompanion.nvim', version = '20.0.1' },
          },
          handlers = {
            lifecycle = {
              setup = function() return true end,
              -- Pi already reads provider credentials from its own configuration.
              auth = function() return true end,
            },
            request = { build_messages = helpers.build_messages },
          },
        }
      end,
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionActions<CR>', { desc = 'AI actions' })
vim.keymap.set({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionChat Toggle<CR>', { desc = 'AI chat (Pi)' })
vim.keymap.set('v', '<leader>ae', ':CodeCompanion ', { desc = 'AI edit selection (Pi)' })

-- Never show line numbers in CodeCompanion buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'codecompanion',
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})
