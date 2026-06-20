return {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    ---@module 'render-markdown'
    ft = { "markdown", "norg", "rmd", "org" },
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
    opts = {
        restart_highlighter = true,
        heading = {
            sign = false,
            icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
        },
        code = {
            sign = false,
            width = "block",
            right_pad = 1,
        },
        bullet = {
            -- Turn on / off list bullet rendering
            enabled = true,
        },
        checkbox = {
            -- Turn on / off checkbox state rendering
            enabled = true,
            unchecked = {
                -- Replaces '[ ]' of 'task_list_marker_unchecked'
                icon = "   󰄱 ",
                -- Highlight for the unchecked icon
                highlight = "RenderMarkdownUnchecked",
                -- Highlight for item associated with unchecked checkbox
                scope_highlight = nil,
            },
            checked = {
                -- Replaces '[x]' of 'task_list_marker_checked'
                icon = "   󰱒 ",
                -- Highlight for the checked icon
                highlight = "RenderMarkdownChecked",
                -- Highlight for item associated with checked checkbox
                scope_highlight = nil,
            },
        },
        html = {
            comment = {
                conceal = false,
            },
        },
    },
}
