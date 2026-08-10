std = "luajit"
globals = { "vim" }
-- Match .stylua.toml column_width = 160
max_line_length = 160
-- 212 = unused argument: LSP/event callback signatures require the argument
-- even when it is not used (e.g. on_attach(client, bufnr))
ignore = { "212" }
