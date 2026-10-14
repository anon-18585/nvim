return {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
            local config = require("nvim-treesitter.config")
            config.setup({
                highlight = {
                    enable = true,
                },
                indent = { enable = true },
                autotage = { enable = true },
                ensure_installed = {
                    "lua",
                    "luadoc",
                    "nix",
                    "markdown",
                    "shell",
                    "fish",
                    "html",
                    "kitty",
                    "kdl",
                    "kcl",
                    "toml",
                    "vimdoc",
                    "yaml",
                    "zig",
                    "bash",
                },
                auto_install = false,
            })
      end
}
