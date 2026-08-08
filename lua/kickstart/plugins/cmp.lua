-- nvim-cmp: autocompletion engine

return {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    -- snippet engine
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },

    -- completion sources
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',  -- cmdline completion
  },

  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    -- completion icons (kind icons)
    local kind_icons = {
      Text = '󰉿',
      Method = '󰆧',
      Function = '󰊕',
      Constructor = '',
      Field = '󰜢',
      Variable = '󰀫',
      Class = '󰠱',
      Interface = '',
      Module = '',
      Property = '󰜢',
      Unit = '󰑭',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '󰈇',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰏿',
      Struct = '󰙅',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '',
    }

    -- main completion setup
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- bordered window
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = 'Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None',
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = 'Normal:CmpDocNormal,FloatBorder:CmpDocBorder',
        }),
      },

      completion = {
        completeopt = 'menu,menuone,noinsert',
      },

      -- keybindings
    mapping = cmp.mapping.preset.insert {
      -- navigate completion with ctrl+j/k
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm { select = true },

      -- disable arrow keys completely
      ['<Down>'] = cmp.mapping(function() end, { 'i', 's' }),
      ['<Up>'] = cmp.mapping(function() end, { 'i', 's' }),

      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
      -- sources (priority order)
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      }, {
        { name = 'buffer' },
      }),

      -- formatting with icons
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, item)
          item.kind = string.format('%s %s', kind_icons[item.kind] or '', item.kind)
          item.menu = ({
            nvim_lsp = '[LSP]',
            luasnip  = '[Snip]',
            buffer   = '[Buf]',
            path     = '[Path]',
            cmdline  = '[CMD]',
          })[entry.source.name]
          return item
        end,
      },
    }

    -- search completion for / and ?
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- command completion for :
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,
}
