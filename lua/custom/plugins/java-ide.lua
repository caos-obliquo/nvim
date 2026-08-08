-- java ide setup via jdtls with mason 2.0 api

return {
  {
    'mfussenegger/nvim-jdtls',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    ft = { 'java' },
    config = function()
      -- check if a mason package is installed
      local function is_mason_package_installed(package_name)
        local ok, mason_registry = pcall(require, 'mason-registry')
        if not ok then
          return false
        end
        return mason_registry.is_installed(package_name)
      end

      -- get mason package path (mason 2.0 compatible)
      local function get_mason_package_path(package_name)
        -- mason 2.0 uses the $mason env var
        return vim.fn.expand('$MASON/packages/' .. package_name)
      end

      -- create an autocommand that runs when opening a java file
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        callback = function()
          -- check if jdtls is installed
          if not is_mason_package_installed('jdtls') then
            vim.notify(
              'JDTLS is not installed!\n\nInstall it with: :MasonInstall jdtls',
              vim.log.levels.ERROR
            )
            return
          end

          local jdtls = require('jdtls')
          
          -- get jdtls path via mason 2.0
          local jdtls_path = get_mason_package_path('jdtls')
          
          -- verify the path exists
          if vim.fn.isdirectory(jdtls_path) == 0 then
            vim.notify('JDTLS path not found: ' .. jdtls_path, vim.log.levels.ERROR)
            return
          end

          -- get debug bundles
          local function get_bundles()
            local bundles = {}
            
            -- java debug adapter
            if is_mason_package_installed('java-debug-adapter') then
              local java_debug_path = get_mason_package_path('java-debug-adapter')
              local debug_jar = vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar')
              if debug_jar ~= '' then
                table.insert(bundles, debug_jar)
              end
            end
            
            -- java test
            if is_mason_package_installed('java-test') then
              local java_test_path = get_mason_package_path('java-test')
              local test_jars = vim.split(vim.fn.glob(java_test_path .. '/extension/server/*.jar', true), '\n')
              if #test_jars > 0 then
                vim.list_extend(bundles, test_jars)
              end
            end
            
            return bundles
          end

          local bundles = get_bundles()

          -- find project root
          local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
          local root_dir = require('jdtls.setup').find_root(root_markers)
          if not root_dir then
            root_dir = vim.fn.getcwd()
          end

          local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
          local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/' .. project_name

          -- get platform config folder
          local os_config = 'config_linux'
          if vim.fn.has('mac') == 1 then
            os_config = 'config_mac'
          elseif vim.fn.has('win32') == 1 then
            os_config = 'config_win'
          end

          -- find launcher jar
          local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
          if launcher_jar == '' then
            vim.notify('JDTLS launcher JAR not found!', vim.log.levels.ERROR)
            return
          end

          -- get java executable
          local java_cmd = vim.fn.exepath('java')
          if java_cmd == '' then
            java_cmd = '/usr/bin/java'
          end

          if vim.fn.executable(java_cmd) == 0 then
            vim.notify('Java executable not found! Please install Java 17 or higher.', vim.log.levels.ERROR)
            return
          end

          -- get bundles
          local bundles = get_bundles()
          
          -- notify about bundles status
          if #bundles > 0 then
            vim.notify('Loaded ' .. #bundles .. ' debug bundles', vim.log.levels.INFO)
          else
            vim.notify('No debug bundles loaded. Install: java-debug-adapter and java-test', vim.log.levels.WARN)
          end

          -- jdtls configuration
          local config = {
            cmd = {
              java_cmd,
              '-Declipse.application=org.eclipse.jdt.ls.core.id1',
              '-Dosgi.bundles.defaultStartLevel=4',
              '-Declipse.product=org.eclipse.jdt.ls.core.product',
              '-Dlog.protocol=true',
              '-Dlog.level=ALL',
              '-Xms1g',
              '-Xmx2g',
              '--add-modules=ALL-SYSTEM',
              '--add-opens', 'java.base/java.util=ALL-UNNAMED',
              '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
              '-jar', launcher_jar,
              '-configuration', jdtls_path .. '/' .. os_config,
              '-data', workspace_dir,
            },
            root_dir = root_dir,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            init_options = {
              bundles = bundles,
            },
            on_attach = function(client, bufnr)
              -- setup dap with explicit configuration
              local dap = require('dap')
              
              -- setup jdtls dap first
              jdtls.setup_dap({ hotcodereplace = 'auto' })
              
              -- ensure java dap configuration exists
              if not dap.configurations.java then
                dap.configurations.java = {}
              end
              
              -- add default java debug configs if missing
              if #dap.configurations.java == 0 then
                dap.configurations.java = {
                  {
                    type = 'java',
                    request = 'attach',
                    name = "Debug (Attach) - Remote",
                    hostName = "127.0.0.1",
                    port = 5005,
                  },
                  {
                    type = 'java',
                    request = 'launch',
                    name = "Debug (Launch) - Current File",
                    mainClass = "${file}",
                  },
                }
              end
              
              -- setup dap main class configs
              pcall(function()
                require('jdtls.dap').setup_dap_main_class_configs()
              end)

              -- keymaps
              local opts = { buffer = bufnr, silent = true }
              
              -- java specific commands
              vim.keymap.set('n', '<leader>co', jdtls.organize_imports, vim.tbl_extend('force', opts, { desc = 'Organize Imports' }))
              vim.keymap.set('n', '<leader>cxv', jdtls.extract_variable, vim.tbl_extend('force', opts, { desc = 'Extract Variable' }))
              vim.keymap.set('n', '<leader>cxc', jdtls.extract_constant, vim.tbl_extend('force', opts, { desc = 'Extract Constant' }))
              vim.keymap.set('v', '<leader>cxm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], vim.tbl_extend('force', opts, { desc = 'Extract Method' }))
              
              -- test commands
              vim.keymap.set('n', '<leader>dt', jdtls.test_class, vim.tbl_extend('force', opts, { desc = 'Test Class' }))
              vim.keymap.set('n', '<leader>dm', jdtls.test_nearest_method, vim.tbl_extend('force', opts, { desc = 'Test Method' }))
              
              -- dap keymaps
              vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, vim.tbl_extend('force', opts, { desc = 'Debug: Continue' }))
              vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, vim.tbl_extend('force', opts, { desc = 'Debug: Toggle Breakpoint' }))
              
              vim.notify('JDTLS attached to buffer', vim.log.levels.INFO)
            end,
            settings = {
              java = {
                eclipse = {
                  downloadSources = true,
                },
                configuration = {
                  updateBuildConfiguration = "interactive",
                },
                maven = {
                  downloadSources = true,
                },
                implementationsCodeLens = {
                  enabled = true,
                },
                referencesCodeLens = {
                  enabled = true,
                },
                references = {
                  includeDecompiledSources = true,
                },
                format = {
                  enabled = true,
                },
                signatureHelp = { enabled = true },
                completion = {
                  favoriteStaticMembers = {
                    "org.junit.Assert.*",
                    "org.junit.Assume.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "org.junit.jupiter.api.Assumptions.*",
                    "org.junit.jupiter.api.DynamicContainer.*",
                    "org.junit.jupiter.api.DynamicTest.*",
                    "org.mockito.Mockito.*",
                    "org.mockito.ArgumentMatchers.*",
                    "org.mockito.Answers.*",
                  },
                  filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                  },
                },
                sources = {
                  organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                  },
                },
                codeGeneration = {
                  toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                  },
                  useBlocks = true,
                },
              },
            },
          }

          -- start or attach jdtls
          jdtls.start_or_attach(config)
        end,
        group = vim.api.nvim_create_augroup('JdtlsSetup', { clear = true }),
        once = true,  -- only run once per filetype trigger
      })
    end,
  },
}
