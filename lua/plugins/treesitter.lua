return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "csv",
                "dockerfile",
                "gitignore",
                "graphql",
                "html",
                "java",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "norg",
                "python",
                "query",
                "rust",
                "sql",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },

            auto_install = false,

            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>i", -- set to `false` to disable one of the mappings
                    node_incremental = "<leader>ii",
                    scope_incremental = "<leader>sp",
                    node_decremental = "<leader>ij",
                },
            },
            textobjects = {
                select = {
                    enable = true,

                    lookahead = true,

                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'v',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    include_surrounding_whitespace = true,
                },
            },
        })
    end,
}
