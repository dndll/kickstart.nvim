local group = vim.api.nvim_create_augroup('SagaHoverDiag', { clear = true })

vim.o.updatetime = 1000 -- 0.3 s CursorHold delay – tweak to taste
local function is_float(win)
    return vim.api.nvim_win_get_config(win).relative ~= ''
end

return {
    vim.api.nvim_create_autocmd("BufWritePre", {
        group    = vim.api.nvim_create_augroup("auto_mkdir", { clear = true }),
        callback = function(ev)
            local dir = vim.fn.fnamemodify(ev.match, ":p:h")
            if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p") end
        end,
    }),

    vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
        group   = vim.api.nvim_create_augroup("auto_checktime", { clear = true }),
        command = "checktime",
    }),

    vim.api.nvim_create_autocmd("VimResized", {
        group   = vim.api.nvim_create_augroup("auto_resize_splits", { clear = true }),
        command = "wincmd =",
    }),

    vim.api.nvim_create_autocmd("BufWritePre", {
        group    = vim.api.nvim_create_augroup("auto_trim_whitespace", { clear = true }),
        callback = function()
            if vim.bo.filetype ~= "markdown" then
                local view = vim.fn.winsaveview()
                vim.cmd([[%s/\s\+$//e]])
                vim.fn.winrestview(view)
            end
        end,
    }),

    vim.api.nvim_create_autocmd("BufReadPost", {
        group    = vim.api.nvim_create_augroup("auto_last_pos", { clear = true }),
        callback = function()
            local mark = vim.api.nvim_buf_get_mark(0, '"')[1]
            if mark > 1 and mark <= vim.fn.line("$") and vim.bo.filetype ~= "gitcommit" then
                vim.cmd("normal! g`\"zz")
            end
        end,
    }),

    vim.api.nvim_create_autocmd("TermOpen", {
        group    = vim.api.nvim_create_augroup("auto_term_opts", { clear = true }),
        callback = function()
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
        end,
    }),

    vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
        group    = vim.api.nvim_create_augroup("auto_macro_rec", { clear = true }),
        callback = function(ev)
            vim.fn.execute("hi ModeMsg gui=bold")
            if ev.event == "RecordingEnter" then
                vim.o.showmode = true
            else
                vim.o.showmode = false
            end
        end,
    }),

    vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        group    = vim.api.nvim_create_augroup("auto_qf_close", { clear = true }),
        callback = function()
            if #vim.fn.getqflist() == 0 then vim.cmd("cclose") end
            if #vim.fn.getloclist(0) == 0 then vim.cmd("lclose") end
        end,
    }),

    vim.api.nvim_create_autocmd("UIEnter", {
        once     = true,
        callback = function()
            vim.opt.visualbell = true
            vim.opt.belloff = "all"
        end,
    }),

    vim.api.nvim_create_autocmd({ "CursorHold" }, {
        group = vim.api.nvim_create_augroup("saga_hover", { clear = true }),
        callback = function()
            if vim.fn.pumvisible() == 0 and not is_float(0) then
                require("lspsaga.diagnostic.show"):show_diagnostics({ cursor = true, jump = false })
            end
        end,
    }),
    -- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    --   group = group,
    --   callback = function()
    --     -- don’t cover completion pop-ups or other floats
    --     if vim.fn.pumvisible() == 1 then return end
    --     -- bail if there is already an unfocused Saga hover window
    --     for _, win in ipairs(vim.api.nvim_list_wins()) do
    --       if vim.api.nvim_win_get_var(win, 'lspsaga_floating') == 1 then return end
    --     end
    --     saga_show_cursor_diag()
    --   end,
    -- }),

    -- FIXME: this should open up on the right, not just in the middle of the page unexitable
    -- open up outline on large files
    vim.api.nvim_create_autocmd("BufReadPost", {
        pattern  = { "*.rs", "*.lua", "*.ts", "*.go" },
        group    = vim.api.nvim_create_augroup("saga_outline", { clear = true }),
        callback = function()
            if vim.fn.line("$") > 200 then vim.cmd("Lspsaga outline") end
        end,
    }),

    vim.api.nvim_create_autocmd("BufWinEnter", {
        once     = true,
        group    = vim.api.nvim_create_augroup("blink_rg_warm", { clear = true }),
        callback = function()
            pcall(function() require("blink-ripgrep").index_project({ async = true }) end)
        end,
    }),


    -- vim.api.nvim_create_autocmd("BufWritePost", {
    --   pattern  = "*.rs",
    --   group    = vim.api.nvim_create_augroup("rust_check", { clear = true }),
    --   callback = function()
    --     -- run quietly; lspsaga will surface new diagnostics
    --     vim.cmd("silent! RustLsp runWorkspace")
    --   end,
    -- }),

    vim.api.nvim_create_autocmd("User", {
        pattern  = "RustLspProgressDone",
        group    = vim.api.nvim_create_augroup("rust_flash_ca", { clear = true }),
        callback = function()
            require("lspsaga.codeaction"):code_action({
                only_in_cursor = false,
                timeout = 1000, -- milliseconds to keep it visible
            })
        end,
    })
}
-- -- Set up autogroups {{
--   do
--     local __nixvim_autogroups = { nixvim_binds_LspAttach = { clear = true } }

--     for group_name, options in pairs(__nixvim_autogroups) do
--       vim.api.nvim_create_augroup(group_name, options)
--     end
--   end
--   -- }}
--   -- Set up autocommands {{
--   do
--     local __nixvim_autocommands = {
--       {
--         callback = function()
--           require("lint").try_lint()
--         end,
--         event = "BufWritePost",
--       },
--       {
--         callback = function()
--           do
--             local __nixvim_binds = {}
--             for i, map in ipairs(__nixvim_binds) do
--               vim.keymap.set(map.mode, map.key, map.action, map.options)
--             end
--           end
--         end,
--         desc = "Load keymaps for LspAttach",
--         event = "LspAttach",
--         group = "nixvim_binds_LspAttach",
--       },
--     }

--     for _, autocmd in ipairs(__nixvim_autocommands) do
--       vim.api.nvim_create_autocmd(autocmd.event, {
--         group = autocmd.group,
--         pattern = autocmd.pattern,
--         buffer = autocmd.buffer,
--         desc = autocmd.desc,
--         callback = autocmd.callback,
--         command = autocmd.command,
--         once = autocmd.once,
--         nested = autocmd.nested,
--       })
--     end
--   end

-- -- Autocommands
-- vim.api.nvim_create_augroup("nixvim_autogroups", { clear = true })

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = "nixvim_autogroups",
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = "nixvim_autogroups",
--   callback = function(args)
--     -- Load keymaps for LspAttach if needed
--     -- Example:
--     -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = args.buf, desc = "Go to Definition" })
--   end,
-- })
