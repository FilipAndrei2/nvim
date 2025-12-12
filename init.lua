-- Lider key
vim.g.mapleader = " "
-- Local lider key (folosita pentru comenzi legate de anumite limbaje, fisiere, comenzi "locale")
vim.g.maplocalleader = "\\"

-- disable netrw at the very start of your init.lua (setare recomandata pentru nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Setari enviorment

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentare
vim.opt.expandtab = true		-- Foloseste spatii in loc de tab
vim.opt.tabstop = 4 			-- Cate spatii reprezinta un tab
vim.opt.shiftwidth = 4       	-- Cate spatii se foloseste pt indentarea automata
vim.opt.softtabstop = 4 		-- Foloseste aceeasi latime la autoindent
vim.opt.autoindent = true 		-- Pastreaza indentarea liniei precedente
vim.opt.smartindent = true 		-- Indentare automata pt cod
vim.opt.scrolloff = 13          -- Numarul de linii in partea de jos a ecranului

-- Enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

vim.o.signcolumn = "yes"

lazy = require("lazy") -- lazy package manager ftw
lazy.setup("plugins") -- Incarca pluginurile mele

-- Seteaza folosirea clipboardului sistemului
vim.o.clipboard = "unnamedplus"

-- KEYMAPS


-- Plugins keymaps

-- Telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", function() telescope.find_files({hidden = true}) end, { desc = "Find files including hidden." })

vim.keymap.set("n", "<leader>sgrep", telescope.live_grep, { desc = "Find string in ALL files." })

vim.keymap.set("n", "<leader>grep", function() telescope.live_grep({grep_open_files = true}) end, { desc = "Find string in open files." })

vim.keymap.set("n", "<leader>c", telescope.commands, { desc = "Find neovim [c]ommand" })

vim.keymap.set("n", "<leader>gc", telescope.git_commits, {desc = "List [g]it [c]ommits"})

-- nvim-tree keymaps
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle nvim-tree file tree" } ) -- Ctrl + b deschide arborele

-- Biscuits
vim.keymap.set("n", "<leader>b", 
        function() require("nvim-biscuits").toggle_biscuits() end,
        {
            silent = true,
            desc = "Toggle code [b]iscuits" 
        }
)
