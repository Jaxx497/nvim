return {
    "rebelot/heirline.nvim",
    dependencies = {
        'echasnovski/mini.icons'
    },
    config = function()
        MiniIcons = require('mini.icons').setup()
        local conditions = require("heirline.conditions")
        local utils = require("heirline.utils")

        local Start = {
            provider = "  ",
            hl = {
                fg = "purple"
            }
        }
        local Align = { provider = "%=" }
        local Space = { provider = " " }
        local Spacer = { provider = " | " }

        local colors = {
            bright_bg = utils.get_highlight("Folded").bg,
            bright_fg = utils.get_highlight("Folded").fg,
            red = utils.get_highlight("DiagnosticError").fg,
            dark_red = utils.get_highlight("DiffDelete").bg,
            green = utils.get_highlight("String").fg,
            blue = utils.get_highlight("Function").fg,
            gray = utils.get_highlight("NonText").fg,
            orange = utils.get_highlight("Constant").fg,
            purple = utils.get_highlight("Statement").fg,
            cyan = utils.get_highlight("Special").fg,
            diag_warn = utils.get_highlight("DiagnosticWarn").fg,
            diag_error = utils.get_highlight("DiagnosticError").fg,
            diag_hint = utils.get_highlight("DiagnosticHint").fg,
            diag_info = utils.get_highlight("DiagnosticInfo").fg,
            git_del = utils.get_highlight("diffDeleted").fg,
            git_add = utils.get_highlight("diffAdded").fg,
            git_change = utils.get_highlight("diffChanged").fg,
        }

        require("heirline").load_colors(colors)

        local ViMode = {
            init = function(self)
                self.mode = vim.fn.mode(1) -- :h mode()
            end,
            static = {
                mode_names = { -- change the strings if you like it vvvvverbose!
                    n = "Normal",
                    no = "Normal",
                    nov = "Normal",
                    noV = "Normal",
                    ["no\22"] = "Normal",
                    niI = "Normal",
                    niR = "Normal",
                    niV = "Normal",
                    nt = "Normal",
                    v = "Visual",
                    vs = "Vs",
                    V = "Visual Line",
                    Vs = "Vs",
                    -- ["\22"] = "^V",
                    ["\22"] = "Visual Block",
                    ["\22s"] = "Visual Block",
                    s = "S",
                    S = "S_",
                    ["\19"] = "^S",
                    i = "Insert",
                    ic = "Ic",
                    ix = "Ix",
                    R = "Replace",
                    Rc = "Rc",
                    Rx = "Rx",
                    Rv = "Rv",
                    Rvc = "Rv",
                    Rvx = "Rv",
                    c = "C",
                    cv = "Ex",
                    r = "...",
                    rm = "M",
                    ["r?"] = "?",
                    ["!"] = "!",
                    t = "Terminal",
                },
                mode_colors = {
                    n = "red",
                    i = "green",
                    v = "cyan",
                    V = "cyan",
                    ["\22"] = "cyan",
                    c = "orange",
                    s = "purple",
                    S = "purple",
                    ["\19"] = "purple",
                    R = "orange",
                    r = "orange",
                    ["!"] = "red",
                    t = "red",
                }
            },
            provider = function(self)
                return " %2(" .. self.mode_names[self.mode] .. "%)"
            end,
            hl = function(self)
                local mode = self.mode:sub(1, 1) -- get only the first mode character
                return { fg = self.mode_colors[mode], bold = true, }
            end,
            update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                    vim.cmd("redrawstatus")
                end),
            },
        }

        local FileNameBlock = {
            -- let's first set up some attributes needed by this component and its children
            init = function(self)
                self.filename = vim.api.nvim_buf_get_name(0)
            end,
        }
        -- We can now define some children separately and add them later


        local icon_color_map = {
            MiniIconsAzure = "#007fff",
            MiniIconsBlue = "#0000ff",
            MiniIconsCyan = "#00ffff",
            MiniIconsGreen = "#00ff00",
            MiniIconsGrey = "#808080",
            MiniIconsOrange = "#ffa500",
            MiniIconsPurple = "#800080",
            MiniIconsRed = "#ff0000",
            MiniIconsYellow = "#ffff00",
        }

        local FileIcon = {
            init = function(self)
                local filename = self.filename
                local extension = vim.fn.fnamemodify(filename, ":e")
                local icon, icon_color, _ = MiniIcons.get('extension', extension)

                self.icon = icon or "?"
                self.icon_color = icon_color_map[icon_color]
            end,
            provider = function(self)
                return self.icon and (self.icon .. " ")
            end,
            hl = function(self)
                return { fg = self.icon_color }
            end
        }

        local FileName = {
            provider = function(self)
                local filename = vim.fn.fnamemodify(self.filename, ":.")
                if filename:match("oil") then return "Oil [" .. filename:sub(7, -1) .. "]" end
                if filename == "sh" then return "fzf" end
                if filename:match("zsh") then return "ZSH" end
                if filename == "" then return "[No Name]" end
                return vim.fn.fnamemodify(filename, ":t")
            end,
            hl = { fg = utils.get_highlight("Directory").fg },
        }

        local FileFlags = {
            {
                condition = function()
                    return vim.bo.modified
                end,
                provider = "",

                hl = { fg = "green" },
            },
            {
                condition = function()
                    return not vim.bo.modifiable or vim.bo.readonly
                end,
                provider = " ",
                hl = { fg = "orange" },
            },
        }

        local FileNameModifer = {
            hl = function()
                if vim.bo.modified then
                    return { fg = "cyan", bold = true, force = true }
                end
            end,
        }

        FileNameBlock = utils.insert(FileNameBlock,
            FileIcon,
            utils.insert(FileNameModifer, FileName),
            Space,
            FileFlags,
            { provider = '%<' }
        )

        local Ruler = {
            -- %l = current line number
            -- %L = number of lines in the buffer
            -- %c = column number
            -- %P = percentage through file of displayed window
            provider = "%l:%2c",
        }

        local LSPActive = {
            condition = conditions.lsp_attached,
            update = { 'LspAttach', 'LspDetach' },

            provider = function()
                local names = {}
                for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    table.insert(names, server.name)
                end
                return " LSP: " .. table.concat(names, " ") .. ""
            end,
            hl = { fg = "green", italic = true },
        }



        local StatusLine = {
            Start,
            ViMode,
            Spacer,
            FileNameBlock,
            Align,
            LSPActive,
            Align,
            Ruler,
        }


        require('heirline').setup({
            statusline = StatusLine
        })
    end,
}
