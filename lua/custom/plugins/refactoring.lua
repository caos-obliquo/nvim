return {
    "theprimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("refactoring").setup({})

        -- Extract function works in visual mode
        vim.keymap.set("x", "<leader>re", function()
            require("refactoring").refactor("Extract Function")
        end)

        -- Extract variable works in visual mode
        vim.keymap.set("x", "<leader>rv", function()
            require("refactoring").refactor("Extract Variable")
        end)

        -- Inline variable works in normal and visual mode
        vim.keymap.set({ "n", "x" }, "<leader>ri", function()
            require("refactoring").refactor("Inline Variable")
        end)

        -- Extract block works in normal mode
        vim.keymap.set("n", "<leader>rb", function()
            require("refactoring").refactor("Extract Block")
        end)
    end,
}
