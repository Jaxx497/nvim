return {
    "rebelot/heirline.nvim",
    dependencies = {
        'echasnovski/mini.icons'
    },
    config = function()
        local conditions = require("heirline.conditions")
        local utils = require("heirline.utils")

        local Align = { provider = "%=" }
        local Space = { provider = "  " }
        local Block = { provider = " ▊ ", hl = { fg = "#d000d0" } }

        local colors = {
            bright_bg = utils.get_highlight("Folded").bg,
            bright_fg = utils.get_highlight("Folded").fg,
            red = "#ff4040",
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
            git_change = utils.get_highlight("diffChanged").fg
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
                    c = "Command",
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
            provider = function(_) -- Replace _ with self
                -- return " %2(" .. self.mode_names[self.mode] .. "%)"
                return ""
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
            init = function(self)
                self.filename = vim.api.nvim_buf_get_name(0)
            end,
        }

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

        local FileName = {
            provider = function(self)
                local filename = vim.fn.fnamemodify(self.filename, ":p:~")
                local ft = vim.bo.filetype

                if ft == "fzf" then return "fzf " end
                if ft == "zsh" then return "zsh " end

                if filename:match("oil") then
                    local path = filename:gsub("oil:///home/[^/]+/", "~/")
                    if not conditions.width_percent_below(#path, 0.20) then
                        path = vim.fn.pathshorten(path)
                    end
                    return "Oil: " .. path
                end

                return vim.fn.fnamemodify(filename, ":t")
            end,
            hl = { fg = utils.get_highlight("directory").fg },
        }

        local FileFlags = {
            {
                condition = function()
                    return vim.bo.modified
                end,
                provider = "[+]",
                hl = { fg = "purple" },
            },
            {
                condition = function()
                    return not vim.bo.modifiable or vim.bo.readonly
                end,
                provider = "",
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

        FileNameBlock = utils.insert(
            FileNameBlock,
            utils.insert(FileNameModifer, FileName),
            FileFlags,
            { provider = '%<' }
        )

        local Ruler = {
            -- %l = current line number
            -- %L = number of lines in the buffer
            -- %c = column number
            -- %P = percentage through file of displayed window
            -- provider = "%3l:%2c",
            provider = "%3l:%2c",
        }

        local FileIcon = {
            init = function(self)
                local filename = vim.api.nvim_buf_get_name(0)
                local extension = vim.fn.fnamemodify(filename, ":e")
                local icon, icon_color, _ = require('mini.icons').get('extension', extension)

                self.icon = icon or ""
                self.icon_color = icon_color_map[icon_color]
            end,
            provider = function(self)
                return self.icon and (self.icon .. " ")
            end,
            hl = function(self)
                return { fg = self.icon_color }
            end
        }

        -- LSP Status component
        local LSPStatus = {
            init = function(self)
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                self.has_lsp = next(clients) ~= nil
            end,
            provider = function(self)
                if self.has_lsp then
                    local names = {}
                    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                        table.insert(names, server.name)
                    end
                    return table.concat(names, " & ")
                else
                    return "No LSP Attached"
                end
            end,
            hl = function(self)
                if self.has_lsp then
                    return {
                        fg = "#00f0ff",
                        italic = true
                    }
                else
                    return {
                        fg = "grey"
                    }
                end
            end
        }

        -- Combined LSPActive component
        local LSPActive = {
            update = { 'LspAttach', 'LspDetach' },

            provider = "LSP: ",
            hl = {
                fg = "grey",
                italic = true
            },
            FileIcon,
            LSPStatus
        }

        local Diagnostics = {

            condition = conditions.has_diagnostics,

            static = {
                error_icon = " ",
                warn_icon = " ",
                hint_icon = "󰠠 ",
                info_icon = " "
            },

            init = function(self)
                self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            end,

            update = { "DiagnosticChanged", "BufEnter" },

            {
                provider = function(self)
                    return self.errors > 0 and (self.error_icon .. self.errors .. " ")
                end,
                hl = { fg = "diag_error" },
            },
            {
                provider = function(self)
                    return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
                end,
                hl = { fg = "diag_warn" },
            },
            {
                provider = function(self)
                    return self.info > 0 and (self.info_icon .. self.info .. " ")
                end,
                hl = { fg = "diag_info" },
            },
            {
                provider = function(self)
                    return self.hints > 0 and (self.hint_icon .. self.hints)
                end,
                hl = { fg = "diag_hint" },
            },
        }

        local Git = {
            condition = conditions.is_git_repo,

            init = function(self)
                self.status_dict = vim.b.gitsigns_status_dict
                self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or
                    self.status_dict.changed ~= 0
            end,

            hl = { fg = "orange" },

            { -- git branch name
                provider = function(self)
                    return " " .. self.status_dict.head
                end,
                hl = { bold = true }
            },
            {
                condition = function(self)
                    return self.has_changes
                end,
            },
            {
                provider = function(self)
                    local count = self.status_dict.added or 0
                    return count > 0 and ("   " .. count)
                end,
                hl = { fg = "git_add" },
            },
            {
                provider = function(self)
                    local count = self.status_dict.changed or 0
                    return count > 0 and (" 󰝤 " .. count)
                end,
                hl = { fg = "#00f0ff" },
            },
            {
                provider = function(self)
                    local count = self.status_dict.removed or 0
                    return count > 0 and ("  " .. count)
                end,
                hl = { fg = "#ff0020" },
            },
            {
                condition = function(self)
                    return self.has_changes
                end,
            },
        }

        local SearchCount = {
            init = function(self)
                local ok, search = pcall(vim.fn.searchcount)
                if ok and search.total then
                    self.search = search
                    self.search_string = vim.fn.getreg('/')
                end
            end,

            provider = function(self)
                local search = self.search
                local total = math.min(search.total, search.maxcount)
                if search.total > 0 then
                    -- return string.format('%s [%d/%d]', self.search_string, search.current, total)
                    return string.format('[%d/%d]', search.current, total)
                else
                    return ""
                end
            end,
            hl = { fg = utils.get_highlight('Color11fg').fg, bold = true }
        }

        local StatusLine = {
            Block,
            ViMode,
            Space,
            FileNameBlock,
            Space,
            Ruler,
            Space,
            Diagnostics,
            Space,
            Align,
            LSPActive,
            Space,
            Align,
            SearchCount,
            Space,
            Git,
            Block,
        }

        require('heirline').setup({
            statusline = StatusLine
        })
    end,
}
