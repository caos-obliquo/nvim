return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Dracula colors
      local colors = {
        bg = '#282a36',
        fg = '#f8f8f2',
        purple = '#bd93f9',
        pink = '#ff79c6',
        cyan = '#8be9fd',
        green = '#50fa7b',
        orange = '#ffb86c',
        red = '#ff5555',
        yellow = '#f1fa8c',
        comment = '#6272a4',
        selection = '#44475a',
        darker_bg = '#21222c',
      }

      local dracula_custom = {
        normal = {
          a = { bg = colors.purple, fg = colors.bg, gui = 'bold' },
          b = { bg = colors.selection, fg = colors.fg },
          c = { bg = colors.darker_bg, fg = colors.fg },
        },
        insert = {
          a = { bg = colors.green, fg = colors.bg, gui = 'bold' },
          b = { bg = colors.selection, fg = colors.fg },
          c = { bg = colors.darker_bg, fg = colors.fg },
        },
        visual = {
          a = { bg = colors.orange, fg = colors.bg, gui = 'bold' },
          b = { bg = colors.selection, fg = colors.fg },
          c = { bg = colors.darker_bg, fg = colors.fg },
        },
        replace = {
          a = { bg = colors.red, fg = colors.bg, gui = 'bold' },
          b = { bg = colors.selection, fg = colors.fg },
          c = { bg = colors.darker_bg, fg = colors.fg },
        },
        command = {
          a = { bg = colors.yellow, fg = colors.bg, gui = 'bold' },
          b = { bg = colors.selection, fg = colors.fg },
          c = { bg = colors.darker_bg, fg = colors.fg },
        },
        inactive = {
          a = { bg = colors.selection, fg = colors.comment },
          b = { bg = colors.darker_bg, fg = colors.comment },
          c = { bg = colors.darker_bg, fg = colors.comment },
        },
      }

      -- FULL mode names (you have space!)
      local function mode_fullname()
        local mode_map = {
          ['n']    = 'NORMAL',
          ['no']   = 'O-PENDING',
          ['nov']  = 'O-PENDING',
          ['noV']  = 'O-PENDING',
          ['no\22'] = 'O-PENDING',
          ['niI']  = 'NORMAL',
          ['niR']  = 'NORMAL',
          ['niV']  = 'NORMAL',
          ['nt']   = 'NORMAL',
          ['ntT']  = 'NORMAL',
          ['v']    = 'VISUAL',
          ['vs']   = 'VISUAL',
          ['V']    = 'V-LINE',
          ['Vs']   = 'V-LINE',
          ['\22']  = 'V-BLOCK',
          ['\22s'] = 'V-BLOCK',
          ['s']    = 'SELECT',
          ['S']    = 'S-LINE',
          ['\19']  = 'S-BLOCK',
          ['i']    = 'INSERT',
          ['ic']   = 'INSERT',
          ['ix']   = 'INSERT',
          ['R']    = 'REPLACE',
          ['Rc']   = 'REPLACE',
          ['Rx']   = 'REPLACE',
          ['Rv']   = 'V-REPLACE',
          ['Rvc']  = 'V-REPLACE',
          ['Rvx']  = 'V-REPLACE',
          ['c']    = 'COMMAND',
          ['cv']   = 'EX',
          ['ce']   = 'EX',
          ['r']    = 'REPLACE',
          ['rm']   = 'MORE',
          ['r?']   = 'CONFIRM',
          ['!']    = 'SHELL',
          ['t']    = 'TERMINAL',
        }
        
        local mode = vim.fn.mode()
        return mode_map[mode] or mode:upper()
      end

      -- DAP status
      local function dap_status()
        local ok, dap = pcall(require, 'dap')
        if not ok then
          return ''
        end
        local status = dap.status()
        if status ~= '' then
          return ' ' .. status
        end
        return ''
      end

      -- LSP clients
      local function lsp_clients()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return ''
        end
        
        local client_names = {}
        for _, client in ipairs(clients) do
          local name = client.name
          if name == 'rust_analyzer' then name = 'rust-analyzer'
          elseif name == 'typescript-tools' or name == 'tsserver' then name = 'ts'
          elseif name == 'pyright' or name == 'pylsp' then name = 'py'
          elseif name == 'lua_ls' then name = 'lua'
          elseif name == 'gopls' then name = 'go'
          elseif name == 'clangd' then
          local ft = vim.bo.filetype
          if ft == 'c' then name = 'c'
          elseif ft == 'cpp' then name = 'c++'
          else name = 'clangd'
          end
          elseif name == 'yamlls' then name = 'yaml'
          elseif name == 'bashls' or name == 'bash-language-server' then name = 'bash'
          elseif name == 'zls' then name = 'zig'
          end
          table.insert(client_names, name)
        end
        return '  ' .. table.concat(client_names, ' ')
      end

      -- Custom filetype with PROPER Nerd Font icons from cheat sheet
      local function filetype_with_icon()
        local filetype = vim.bo.filetype
        if filetype == '' then
          return ''
        end
        
        -- Nerd Font icons from https://www.nerdfonts.com/cheat-sheet
        local nerd_icons = {
          -- Your main languages
          rust = '',           -- nf-dev-rust
          python = '',         -- nf-dev-python
          javascript = '',     -- nf-dev-javascript
          typescript = '',     -- nf-seti-typescript
          go = '󰟓',            -- nf-dev-go
          lua = '',           -- nf-seti-lua
          c = '',             -- nf-dev-c
          cpp = '',           -- nf-dev-cplusplus
          
          -- Additional languages
          yaml = '',          -- nf-dev-yaml
          yml = '',           -- nf-dev-yaml
          helm = '',          -- helm symbol
          sh = '',            -- nf-dev-terminal
          bash = '',          -- nf-dev-terminal
          zsh = '%_',           -- nf-dev-terminal
          zig = '',           -- nf-seti-zig
          
          -- Common extras
          json = '',          -- nf-seti-json
          toml = '',          -- nf-seti-config
          markdown = '',      -- nf-dev-markdown
          nvim = '',          -- nf-dev-nvim
          vim = '',           -- nf-dev-vim
          html = '',          -- nf-dev-html5
          css = '',           -- nf-dev-css3
          dockerfile = '',    -- nf-dev-docker
          gitcommit = '',     -- nf-dev-git
        }
        
        local icon = nerd_icons[filetype]
        
        if icon then
          return icon .. ' ' .. filetype
        end
        return filetype
      end

      require('lualine').setup({
        options = {
          theme = dracula_custom,
          component_separators = '',
          section_separators = '',
          globalstatus = false,
        },
        sections = {
          -- Left side
          lualine_a = { 
            {
              mode_fullname,
              padding = { left = 1, right = 1 },
            },
          },
          lualine_b = { 
            {
              'branch',
              icon = '', -- Proper git branch icon from Nerd Fonts
              color = { fg = colors.purple, gui = 'bold' },
              padding = { left = 1, right = 1 },
            },
            {
              'diff',
              colored = true,
              diff_color = {
                added    = { fg = colors.green },
                modified = { fg = colors.orange },
                removed  = { fg = colors.red },
              },
              symbols = { added = ' ', modified = ' ', removed = ' ' },
            },
          },
          lualine_c = { 
            {
              'filename',
              path = 1,
              symbols = {
                modified = ' ●',
                readonly = ' ',
                unnamed = '[No Name]',
                newfile = ' ',
              },
              color = { fg = colors.cyan },
            },
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              sections = { 'error', 'warn', 'info', 'hint' },
              symbols = { 
                error = ' ', 
                warn = ' ', 
                info = ' ', 
                hint = ' ',
              },
              colored = true,
              diagnostics_color = {
                error = { fg = colors.red },
                warn  = { fg = colors.yellow },
                info  = { fg = colors.cyan },
                hint  = { fg = colors.comment },
              },
            },
          },
          
          -- Right side
          lualine_x = {
            {
              dap_status,
              color = { fg = colors.red, gui = 'bold' },
            },
            {
              lsp_clients,
              color = { fg = colors.green },
            },
            {
              'encoding',
              fmt = function(str)
                if str == 'utf-8' then return '' end
                return str
              end,
            },
            {
              'fileformat',
              symbols = {
                unix = '',
                dos = '',
                mac = '',
              },
              fmt = function(str)
                if str == '' then return '' end
                return str
              end,
            },
            {
              filetype_with_icon,
              color = { fg = colors.pink },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_y = { 
            {
              'progress',
              color = { fg = colors.comment },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_z = { 
            {
              'location',
              padding = { left = 0, right = 1 }, -- Compact! No left padding
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 
            {
              'filename',
              color = { fg = colors.comment },
            },
          },
          lualine_x = { 
            {
              'location',
              color = { fg = colors.comment },
            },
          },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { 'neo-tree', 'lazy', 'mason' },
      })
    end,
  },
}
