-- LSP Configuration - Using NEW nvim 0.11 API (vim.lsp.enable)
-- This is why gd, K, gr now WORK!

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = {
              winblend = 0, -- 0 = transparent, 100 = opaque (default was 100!)
              border = 'none',
              normal_hl = 'Comment',
            },
          },
        },
      },
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      -- Setup Mason first
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'rust_analyzer',
          'ts_ls',
          'pyright',
          'gopls',
          'clangd',
          'zls',
          'yamlls',
          'bashls',
          'jsonls',
          'terraformls',
          'dockerls',
          'html',
          'eslint',
          'cssls',
          'angularls',
        },
        automatic_installation = true,
      }

      -- Configure LSP capabilities with cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Apply capabilities to ALL servers (new nvim 0.11 way!)
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- yamlls - full schema support via schemastore.nvim
      vim.lsp.config('yamlls', {
        settings = {
          yaml = {
            validate = true,
            completion = true,
            hover = true,
            format = { enable = true },
            -- Pull ALL schemas from SchemaStore (covers 1000+ file types)
            schemaStore = {
              enable = false, -- disable built-in, we use schemastore.nvim below
              url = '',
            },
            schemas = require('schemastore').yaml.schemas {
              -- Extra schemas not in SchemaStore
              extra = {
                {
                  name = 'GitLab CI',
                  description = 'GitLab CI/CD pipeline configuration',
                  fileMatch = { '.gitlab-ci.yml', '.gitlab-ci.yaml' },
                  url = 'https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json',
                },
              },
            },
          },
        },
      })

      -- jsonls - also benefits from schemastore
      vim.lsp.config('jsonls', {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- Enable servers (new nvim 0.11 API - this is why it works!)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            globals = { "vim" },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.enable "lua_ls"
      vim.lsp.enable 'rust_analyzer'
      vim.lsp.enable 'ts_ls'
      vim.lsp.enable 'pyright'
      vim.lsp.enable 'gopls'
      vim.lsp.enable 'clangd'
      vim.lsp.enable 'zls'
      vim.lsp.enable 'yamlls'
      vim.lsp.enable 'bashls'
      vim.lsp.enable 'jsonls'
      vim.lsp.enable 'terraformls'
      vim.lsp.enable 'dockerls'
      vim.lsp.enable 'html'
      vim.lsp.enable 'cssls'
      vim.lsp.enable 'angularls'
      vim.lsp.enable 'eslint'

      -- Keybindings on LSP attach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = 'LSP: ' .. desc }) end

          local tele = require 'telescope.builtin'

          -- Navigation
          map('gd', tele.lsp_definitions, 'Goto Definition')
          map('gr', tele.lsp_references, 'Goto References')
          map('gI', tele.lsp_implementations, 'Goto Implementation')
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          map('<leader>D', tele.lsp_type_definitions, 'Type Definition')

          -- Symbols
          map('<leader>ds', tele.lsp_document_symbols, 'Document Symbols')
          map('<leader>ws', tele.lsp_dynamic_workspace_symbols, 'Workspace Symbols')

          -- Actions
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
          map('<leader>rn', vim.lsp.buf.rename, 'Rename')
          map('<leader>ci', vim.lsp.buf.incoming_calls, 'Incoming Calls')
          map('<leader>cO', vim.lsp.buf.outgoing_calls, 'Outgoing Calls')

          -- Documentation
          map('K', vim.lsp.buf.hover, 'Hover Docs')
          map('<leader>k', vim.lsp.buf.signature_help, 'Signature Help')

          -- Diagnostics
          map('<leader>E', vim.diagnostic.open_float, 'Diagnostic Float')
          map('[d', vim.diagnostic.goto_prev, 'Prev Diagnostic')
          map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')

          -- Visual mode code actions
          vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, {
            buffer = ev.buf,
            desc = 'LSP: Code Action',
          })

          -- Highlight references on cursor hold
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = ev.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = ev.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },
}
