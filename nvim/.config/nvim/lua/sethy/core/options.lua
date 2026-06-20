vim.g.netrw_banner = 0

vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = false
vim.opt.wrap = false

-- backup and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- search
vim.opt.inccommand = "split"

-- UI
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 0
vim.opt.showtabline = 2
vim.opt.tabline = " "

-- folding
vim.o.foldenable = true
vim.o.foldmethod = "manual"
vim.o.foldlevel = 99
vim.o.foldcolumn = "0"

-- window splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- misc
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20"

vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    -- DECSCUSR: 5 = blinking beam, matching kitty's cursor_shape=beam + blink
    io.write("\x1b[5 q")
  end,
})
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "0"
vim.opt.clipboard:append("unnamedplus")
vim.opt.mouse = "a"

-- Force transparent background after every colorscheme change
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
    pattern = "*",
    callback = function()
        vim.schedule(function()
            for _, g in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer", "TabLineFill", "TabLine" }) do
                vim.api.nvim_set_hl(0, g, { bg = "NONE", ctermbg = "NONE" })
            end
        end)
    end,
})

-- Hightlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})
