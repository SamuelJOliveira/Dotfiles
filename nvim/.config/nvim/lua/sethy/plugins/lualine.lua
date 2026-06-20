return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        local colors = {
            color0 = "#101010",
            color1 = "#777777",
            color2 = "#ffffff",
            color3 = "#272727",
            color4 = "#0d0d0d",
            color6 = "#b0b0b0",
            color7 = "#50585d",
            color8 = "#d9ba73",
        }
		local my_lualine_theme = {
			replace = {
				a = { fg = colors.color1, bg = "NONE", gui = "bold" },
				b = { fg = colors.color2, bg = "NONE" },
			},
			inactive = {
				a = { fg = colors.color6, bg = "NONE", gui = "bold" },
				b = { fg = colors.color6, bg = "NONE" },
				c = { fg = colors.color6, bg = "NONE" },
			},
			normal = {
				a = { fg = colors.color7, bg = "NONE", gui = "bold" },
				b = { fg = colors.color2, bg = "NONE" },
				c = { fg = colors.color2, bg = "NONE" },
			},
			visual = {
				a = { fg = colors.color8, bg = "NONE", gui = "bold" },
				b = { fg = colors.color2, bg = "NONE" },
			},
			insert = {
				a = { fg = colors.color2, bg = "NONE", gui = "bold" },
				b = { fg = colors.color2, bg = "NONE" },
			},
		}

        local mode = {
            'mode',
            fmt = function(str)
                return '' .. str
            end,
        }

        local diff = {
            'diff',
            colored = true,
            symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
            -- cond = hide_in_width,
        }

        local filename = {
            'filename',
            file_status = true,
            path = 0,
        }

        local branch = {'branch', icon = {'', color={fg='#777777'}}, '|'}


		vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
			pattern = "*",
			callback = function()
				vim.schedule(function()
					vim.api.nvim_set_hl(0, "StatusLine",   { bg = "NONE", ctermbg = "NONE" })
					vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE" })
				end)
			end,
		})

		lualine.setup({
            icons_enabled = true,
			options = {
				theme = my_lualine_theme,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "|", right = "" },
			},
			sections = {
                lualine_a = { mode },
                lualine_b = { branch },
                lualine_c = { diff, filename },
				lualine_x = {
					{
                        -- require("noice").api.statusline.mode.get,
                        -- cond = require("noice").api.statusline.mode.has,
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#c0c0c0" },
					},
					-- { "encoding",},
					-- { "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
