return {
    -- Catppucin (color theme)
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = true,
                integrations = {
                    treesitter = true,
                    telescope = true,
                    gitsigns = true,
                    cmp = true,
                    which_key = true,
                    lsp_trouble = true,
                },
            })
        end
    },

    -- Yoda (color theme) 
    {
        "kuri-sun/yoda.nvim",

        config = function()
            require("yoda").setup({
                -- Set light or dark variant
                theme = "dark", -- "dark" or "light"

                -- Style options
                italic_comments = false,
                transparent_background = false,
                bold_keywords = false,
                underline_match_paren = false,

                -- Override specific colors
                colors = {}, -- Override palette colors

                -- Override specific highlight groups
                highlights = {}, -- Override highlight groups

                -- Disable or enable colorscheme extensions
                extensions = {
                    telescope = true,
                    nvim_tree = true,
                    cmp = true,
                    gitsigns = true,
                    snacks = true,
                    netrw = true,
                    todo_comments = true,
                    indent_blankline = true,
                    dashboard = true,
                    which_key = true,
                    misc = true,
                    mini = true,
                    noice = true,
                    trouble = true,
                },
            })
        end
    },

    -- Code biscuits for u <
    { 
        'code-biscuits/nvim-biscuits', dependencies = { 'nvim-treesitter/nvim-treesitter', }, 
        opts = { -- Config goes here, 
            default_config = { 
                max_lenth = 14, 
                min_distance = 6, 
                prefix_string = " ▸ ",
                hl_group = "BiscuitColor",
                max_file_size = "100kb"
            }, 
        }, 
        
        config = function(_, opts) 
            require("nvim-biscuits").setup(opts)
            vim.api.nvim_set_hl(
                0, "BiscuitColor",
                {
                    --[[
                    Comment
                    Identifier
                    Function
                    Type
                    Keyword
                    LineNr
                    String
                    --]]
                    link = "Comment", 
                    bold = true,
                }
            )
        end, 
    },

    -- Telescope (fuzzy finder)
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            config = function()
                local telescope = require("telescope")
                telescope.setup({})
                telescope.load_extension("fzf")
            end,
        },

    },

    -- Gitsigns (indicatoare git in margine)
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- LSP si autocmplete
    { "neovim/nvim-lspconfig" },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert(),
                sources = {
                    { name = "nvim_lsp" },
                },
            })
        end,
    },


    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig",
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            -- Daca doresti sa instalezi un lsp in viitor, cauta un lsp documentat la 
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
            -- Adauga-l in tabelul de mai jos si foloseste vim.lsp.config(...) pentru a-i face configurarea conform documentatiei.
            -- Nu uita sa activezi LSP-ul folosind vim.lsp.enable("...") !
            ensure_installed = { "pyright", "rust_analyzer", "lua_ls" }, -- serverele dorite
        })

        -- rust-analyzer configs
        vim.lsp.config("rust_analyzer", {
            settings = {
                ['rust-analyzer'] = {
                    diagnostics = {
                        enable = false;
                    }
                }
            }
        })
        vim.lsp.enable("rust_analyzer")

        -- lua_ls config
    vim.lsp.config('lua_ls', {
        on_init = function(client)
        if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
            return
        end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
            vim.lsp.enable('lua_ls')
        end
    },


    -- Autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup{}
        end
    },

    -- nvim-tree file tree
    {
        "nvim-tree/nvim-tree.lua",
        config = function() 
            require("nvim-tree").setup ({
                filters = {
                    dotfiles = true, -- Ascunde/Afiseaza dotfiles
                }
            })
        end
    },
}
