-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et

-- Set up keybinds {{{
do
  local __nixvim_binds = {
    { action = "<cmd>Telescope git_files<cr>", key = "<C-p>",      mode = "n", options = { desc = "Search git files" } },
    {
      action = "<cmd>Telescope live_grep<cr>",
      key = "<leader>/",
      mode = "n",
      options = { desc = "Grep (root dir)" },
    },
    {
      action = "<cmd>Telescope command_history<cr>",
      key = "<leader>:",
      mode = "n",
      options = { desc = "Command History" },
    },
    -- {
    --   action = "<cmd>Telescope find_files<cr>",
    --   key = "<leader><space>",
    --   mode = "n",
    --   options = { desc = "Find project files" },
    -- },
    { action = "<cmd>Telescope buffers<cr>",   key = "<leader>b",  mode = "n", options = { desc = "+buffer" } },
    { action = "<cmd>Telescope buffers<cr>",   key = "<leader>fb", mode = "n", options = { desc = "Buffers" } },
    {
      action = "<cmd>Telescope find_files<cr>",
      key = "<leader>ff",
      mode = "n",
      options = { desc = "Find project files" },
    },
    { action = "<cmd>Telescope oldfiles<cr>",    key = "<leader>fr", mode = "n", options = { desc = "Recent" } },
    { action = "<cmd>Telescope git_commits<cr>", key = "<leader>gc", mode = "n", options = { desc = "Commits" } },
    { action = "<cmd>Telescope git_status<cr>",  key = "<leader>gs", mode = "n", options = { desc = "Status" } },
    { action = "<cmd>Telescope commands<cr>",    key = "<leader>sC", mode = "n", options = { desc = "Commands" } },
    {
      action = "<cmd>Telescope diagnostics<cr>",
      key = "<leader>lD",
      mode = "n",
      options = { desc = "Workspace diagnostics" },
    },
    {
      action = "<cmd>Telescope highlights<cr>",
      key = "<leader>sH",
      mode = "n",
      options = { desc = "Search Highlight Groups" },
    },
    { action = "<cmd>Telescope man_pages<cr>", key = "<leader>sM", mode = "n", options = { desc = "Man pages" } },
    { action = "<cmd>Telescope resume<cr>",    key = "<leader>sR", mode = "n", options = { desc = "Resume" } },
    {
      action = "<cmd>Telescope autocommands<cr>",
      key = "<leader>sa",
      mode = "n",
      options = { desc = "Auto Commands" },
    },
    {
      action = "<cmd>Telescope current_buffer_fuzzy_find<cr>",
      key = "<leader>sb",
      mode = "n",
      options = { desc = "Buffer" },
    },
    {
      action = "<cmd>Telescope command_history<cr>",
      key = "<leader>sc",
      mode = "n",
      options = { desc = "Command History" },
    },
    { action = "<cmd>Telescope help_tags<cr>",                                                    key = "<leader>sh", mode = "n", options = { desc = "Help pages" } },
    { action = "<cmd>Telescope keymaps<cr>",                                                      key = "<leader>sk", mode = "n", options = { desc = "Keymaps" } },
    { action = "<cmd>Telescope marks<cr>",                                                        key = "<leader>sm", mode = "n", options = { desc = "Jump to Mark" } },
    { action = "<cmd>Telescope vim_options<cr>",                                                  key = "<leader>so", mode = "n", options = { desc = "Options" } },
    { action = function() require("harpoon"):list():add() end,                                    key = "<leader>ha", mode = "n", options = { silent = true } },
    { action = function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, key = "<C-e>",      mode = "n", options = { silent = true } },
    {
      action = function()
        vim.ui.input({ prompt = "Harpoon mark index: " }, function(input)
          local num = tonumber(input)
          if num then require("harpoon"):list():select(num) end
        end)
      end,
      key = "<C-x>",
      mode = "n",
      options = { silent = true },
    },
    {
      action = function() require("harpoon"):list():prev() end,
      key = "<leader>hk",
      mode = "n",
      options = { silent = true },
    },
    {
      action = function() require("harpoon"):list():next() end,
      key = "<leader>hj",
      mode = "n",
      options = { silent = true },
    },
    {
      action = "<cmd>Telescope colorscheme<cr>",
      key = "<leader>uC",
      mode = "n",
      options = { desc = "Colorscheme preview" },
    },
    {
      action = function()
        local bufnr = vim.api.nvim_get_current_buf()
        require("rainbow-delimiters").toggle(bufnr)
        require("astrocore").notify(
          string.format(
            "Buffer rainbow delimeters %s",
            require("rainbow-delimiters").is_enabled(bufnr) and "on" or "off"
          )
        )
      end,
      key = "<leader>u(",
      mode = "n",
      options = { desc = "Toggle Rainbow delimeters" },
    },
    {
      action = "<cmd>UndotreeToggle<CR>",
      key = "<leader>ut",
      mode = "n",
      options = { desc = "Undotree", silent = true },
    },
    {
      action = ":SidebarNvimToggle<CR>",
      key = "<leader>E",
      mode = "n",
      options = { desc = "Toggle Explorer", silent = true },
    },
    {
      action = ":Oil --float<CR>",
      key = "<leader>o",
      mode = "n",
      options = { desc = "Open parent directory", silent = true },
    },
    {
      action = "<cmd>lua require('neotest').run.run(vim.fn.expand '%')<CR>",
      key = "<leader>tt",
      mode = "n",
      options = { desc = "Run File", silent = true },
    },
    {
      action = "<cmd>lua require('neotest').run.run(vim.loop.cwd())<CR>",
      key = "<leader>tT",
      mode = "n",
      options = { desc = "Run All Test Files", silent = true },
    },
    {
      action = "<cmd>lua require('neotest').run.run()<CR>",
      key = "<leader>tr",
      mode = "n",
      options = { desc = "Run Nearest", silent = true },
    },
    {
      action = "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
      key = "<leader>td",
      mode = "n",
      options = { desc = "Run Nearest with debugger", silent = true },
    },
    {
      action = "<cmd>lua require('neotest').summary.toggle()<CR>",
      key = "<leader>ts",
      mode = "n",
      options = { desc = "Toggle Summary", silent = true },
    },
    {
      action = "<cmd>lua require('neotest').output.open{ enter = true, auto_close = true }<CR>",
      key = "<leader>to",
      mode = "n",
      options = { desc = "Show Output", silent = true },
    },
    {
      action = "<cmd>lua require('neotest').output_panel.toggle()<CR>",
      key = "<leader>tO",
      mode = "n",
      options = { desc = "Toggle Output Panel", silent = true },
    },
    {
      action = "<cmd>lua require('neotest').run.stop()<CR>",
      key = "<leader>tS",
      mode = "n",
      options = { desc = "Stop", silent = true },
    },
    { action = "<cmd>+markdown",              key = "<leader>lm", mode = "n", options = { desc = "Markdown" } },
    {
      action = "<cmd>MarkdownPreview<cr>",
      key = "<leader>lmp",
      mode = "n",
      options = { desc = "Markdown Preview" },
    },
    {
      action = function()
        local notify = require("notify")
        local function bool2str(bool) return bool and "on" or "off" end
        local ok, ultimate_autopair = pcall(require, "ultimate-autopair")
        if ok then
          ultimate_autopair.toggle()
          vim.g.ultimate_autopair_enabled = require("ultimate-autopair.core").disable
          notify(string.format("ultimate-autopair %s", bool2str(not vim.g.ultimate_autopair_enabled)))
        else
          notify "ultimate-autopair not available"
        end
      end,
      key = "<leader>ua",
      mode = "n",
      options = { desc = "Toggle Ultimate Autopair" },
    },
    {
      action = function()
        require("hop").hint_words()
      end,
      key = "s",
      mode = "",
      options = { remap = true },
    },
    {
      action = function()
        require("hop").hint_lines()
      end,
      key = "<S-s>",
      mode = "",
      options = { remap = true },
    },
    {
      action = function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
      key = "t",
      mode = "",
      options = { remap = true },
    },
    {
      action = function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = 1,
        })
      end,
      key = "T",
      mode = "",
      options = { remap = true },
    },
    {
      action = '<cmd>lua require("notify").dismiss({ silent = true, pending = true })<cr>\n',
      key = "<leader>un",
      mode = "n",
      options = { desc = "Dismiss All Notifications" },
    },
    { action = "<cmd>Telescope projects<CR>", key = "<leader>fp", mode = "n", options = { desc = "Projects" } },
    {
      action = "<cmd>Telescope diagnostics bufnr=0<cr>",
      key = "<leader>sd",
      mode = "n",
      options = { desc = "Document diagnostics" },
    },
    {
      action = "<cmd>TodoTelescope<cr>",
      key = "<leader>st",
      mode = "n",
      options = { desc = "Todo (Telescope)", silent = true },
    },
    { action = "+diagnostics/quickfix",      key = "<leader>x", mode = "n" },
    {
      action = "<cmd>Trouble diagnostics<cr>",
      key = "<leader>xx",
      mode = "n",
      options = { desc = "Document Diagnostics (Trouble)", silent = true },
    },
    {
      action = "<cmd>Trouble<cr>",
      key = "<leader>xl",
      mode = "n",
      options = { desc = "LSP (Trouble)", silent = true },
    },
    {
      action = "<cmd>Trouble todo<cr>",
      key = "<leader>xt",
      mode = "n",
      options = { desc = "Todo (Trouble)", silent = true },
    },
    {
      action = "<cmd>TodoQuickFix<cr>",
      key = "<leader>xQ",
      mode = "n",
      options = { desc = "Quickfix List (Trouble)", silent = true },
    },
    {
      action = "<cmd>Lspsaga finder def<CR>",
      key = "gd",
      mode = "n",
      options = { desc = "Goto Definition", silent = true },
    },
    {
      action = "<cmd>Lspsaga finder ref<CR>",
      key = "gr",
      mode = "n",
      options = { desc = "Goto References", silent = true },
    },
    {
      action = "<cmd>Lspsaga finder imp<CR>",
      key = "gI",
      mode = "n",
      options = { desc = "Goto Implementation", silent = true },
    },
    {
      action = "<cmd>Lspsaga peek_type_definition<CR>",
      key = "gT",
      mode = "n",
      options = { desc = "Type Definition", silent = true },
    },
    { action = "<cmd>Lspsaga hover_doc<CR>", key = "K",         mode = "n", options = { desc = "Hover", silent = true } },
    {
      action = "<cmd>Lspsaga outline<CR>",
      key = "<leader>lS",
      mode = "n",
      options = { desc = "Outline", silent = true },
    },
    {
      action = "<cmd>Lspsaga rename<CR>",
      key = "<leader>lr",
      mode = "n",
      options = { desc = "Rename", silent = true },
    },
    {
      action = "<cmd>Lspsaga project_replace<CR>",
      key = "<leader>lR",
      mode = "n",
      options = { desc = "Old", silent = true },
    },
    {
      action = "<cmd>Lspsaga code_action<CR>",
      key = "<leader>la",
      mode = "n",
      options = { desc = "Code Action", silent = true },
    },
    {
      action = "<cmd>RustLsp code_action<CR>",
      key = "<leader>ra",
      mode = "n",
      options = { desc = "Rust Code Action", silent = true },
    },
    {
      action = "<cmd>Lspsaga show_line_diagnostics<CR>",
      key = "<leader>ld",
      mode = "n",
      options = { desc = "Line Diagnostics", silent = true },
    },
    {
      action = "<cmd>RustLsp renderDiagnostic current<CR>",
      key = "<leader>rd",
      mode = "n",
      options = { desc = "Line Diagnostics", silent = true },
    },
    {
      action = "<cmd>RustLsp openDocs<CR>",
      key = "<leader>rod",
      mode = "n",
      options = { desc = "Open Documentation for current symbol", silent = true },
    },
    {
      action = "<cmd>RustLsp openParent<CR>",
      key = "<leader>rop",
      mode = "n",
      options = { desc = "Open Parent module for current symbol", silent = true },
    },
    {
      action = "<cmd>Lspsaga diagnostic_jump_next<CR>",
      key = "]d",
      mode = "n",
      options = { desc = "Next Diagnostic", silent = true },
    },
    {
      action = "<cmd>RustLsp renderDiagnostic cycle<CR>",
      key = "]D",
      mode = "n",
      options = { desc = "Next Diagnostic", silent = true },
    },
    {
      action = "<cmd>Lspsaga diagnostic_jump_prev<CR>",
      key = "[d",
      mode = "n",
      options = { desc = "Previous Diagnostic", silent = true },
    },
    {
      action = ":FormatToggle<CR>",
      key = "<leader>uf",
      mode = "n",
      options = { desc = "Toggle Format", silent = true },
    },
    {
      action = "<cmd>lua require('conform').format()<cr>",
      key = "<leader>lf",
      mode = "n",
      options = { desc = "Format Buffer", silent = true },
    },
    {
      action = "<cmd>lua require('conform').format()<cr>",
      key = "<leader>lF",
      mode = "v",
      options = { desc = "Format Lines", silent = true },
    },
    {
      action = "<cmd>TSToolsOrganizeImports<cr>",
      key = "<leader>lo",
      mode = "n",
      options = { desc = "Organize Imports" },
    },
    {
      action = "<cmd>TSToolsRemoveUnusedImports<cr>",
      key = "<leader>lR",
      mode = "n",
      options = { desc = "Remove Unused Imports" },
    },
    -- {
    --   action = "+rustaceanvim",
    --   key = "<leader>r",
    --   mode = { "n", "v" },
    --   options = { desc = "Rustaceanvim", silent = true },
    -- },
    {
      action = "<cmd>:RustLsp joinLines<cr>",
      key = "<leader>lj",
      mode = { "n" },
      options = { desc = "Join Lines", silent = true },
    },
    {
      action = "<cmd>:RustLsp { 'ssr', '<query>' --[[ optional ]] }<cr>",
      key = "<leader>lr",
      mode = { "n" },
      options = { desc = "Structural Search and Replace", silent = true },
    },
    {
      action = "<cmd>:RustLsp parentModule<cr>",
      key = "gp",
      mode = { "n" },
      options = { desc = "Goto Parent Module", silent = true },
    },
    {
      action = "<cmd>:RustLsp openCargo<cr>",
      key = "gm",
      mode = { "n" },
      options = { desc = "Goto Cargo Manifest", silent = true },
    },
    {
      action = "<cmd>:RustLsp explainError<cr>",
      key = "<leader>le",
      mode = { "n" },
      options = { desc = "Explain Error", silent = true },
    },
    {
      action = "<cmd>:RustLsp testables<cr>",
      key = "<leader>lt",
      mode = { "n" },
      options = { desc = "Explore Tests", silent = true },
    },
    {
      action = "<cmd>:RustLsp! testables<cr>",
      key = "<leader>lT",
      mode = { "n" },
      options = { desc = "Rerun last test", silent = true },
    },
    {
      action = "<cmd>:RustLsp runnables<cr>",
      key = "<leader>ll",
      mode = { "n" },
      options = { desc = "Explore Runnables", silent = true },
    },
    {
      action = "<cmd>:RustLsp runnables<cr>",
      key = "<leader>lL",
      mode = { "n" },
      options = { desc = "Explore Runnables", silent = true },
    },
    {
      action = "<cmd>:RustLsp flyCheck<cr>",
      key = "<leader>lc",
      mode = { "n" },
      options = { desc = "FlyCheck", silent = true },
    },
    {
      action = function()
        require("hop").hint_words()
      end,
      key = "s",
      mode = "",
      options = { remap = true },
    },
    {
      action = function()
        require("hop").hint_lines()
      end,
      key = "<S-s>",
      mode = "",
      options = { remap = true },
    },
    {
      action = function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
      key = "t",
      mode = "",
      options = { remap = true },
    },
    {
      action = function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = 1,
        })
      end,
      key = "T",
      mode = "",
      options = { remap = true },
    },
    { action = "<cmd>LazyGit<CR>", key = "<leader>gg", mode = "n",          options = { desc = "LazyGit (root dir)" } },
    { action = "gitsigns",         key = "<leader>gh", mode = { "n", "v" }, options = { desc = "+hunks", silent = true } },
    {
      action = ":Gitsigns blame_line<CR>",
      key = "<leader>ghb",
      mode = "n",
      options = { desc = "Blame line", silent = true },
    },
    {
      action = ":Gitsigns diffthis<CR>",
      key = "<leader>ghd",
      mode = "n",
      options = { desc = "Diff This", silent = true },
    },
    {
      action = ":Gitsigns preview_hunk<CR>",
      key = "<leader>ghp",
      mode = "n",
      options = { desc = "Preview hunk", silent = true },
    },
    {
      action = ":Gitsigns reset_buffer<CR>",
      key = "<leader>ghR",
      mode = "n",
      options = { desc = "Reset Buffer", silent = true },
    },
    {
      action = ":Gitsigns reset_hunk<CR>",
      key = "<leader>ghr",
      mode = { "n", "v" },
      options = { desc = "Reset Hunk", silent = true },
    },
    {
      action = ":Gitsigns stage_hunk<CR>",
      key = "<leader>ghs",
      mode = { "n", "v" },
      options = { desc = "Stage Hunk", silent = true },
    },
    {
      action = ":Gitsigns stage_buffer<CR>",
      key = "<leader>ghS",
      mode = "n",
      options = { desc = "Stage Buffer", silent = true },
    },
    {
      action = ":Gitsigns undo_stage_hunk<CR>",
      key = "<leader>ghu",
      mode = "n",
      options = { desc = "Undo Stage Hunk", silent = true },
    },
    {
      action = ":Neotree toggle reveal_force_cwd<cr>",
      key = "<leader>e",
      mode = "n",
      options = { desc = "Explorer NeoTree (root dir)", silent = true },
    },
    {
      action = ":Neotree buffers<CR>",
      key = "<leader>be",
      mode = "n",
      options = { desc = "Buffer explorer", silent = true },
    },
    {
      action = ":Neotree git_status<CR>",
      key = "<leader>ge",
      mode = "n",
      options = { desc = "Git explorer", silent = true },
    },
    {
      action = "\n        <cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>\n      ",
      key = "<leader>dB",
      mode = "n",
      options = { desc = "Breakpoint Condition", silent = true },
    },
    {
      action = ":DapToggleBreakpoint<cr>",
      key = "<leader>db",
      mode = "n",
      options = { desc = "Toggle Breakpoint", silent = true },
    },
    { action = ":DapContinue<cr>", key = "<leader>dc", mode = "n", options = { desc = "Continue", silent = true } },
    {
      action = "<cmd>lua require('dap').continue({ before = get_args })<cr>",
      key = "<leader>da",
      mode = "n",
      options = { desc = "Run with Args", silent = true },
    },
    {
      action = "<cmd>lua require('dap').run_to_cursor()<cr>",
      key = "<leader>dC",
      mode = "n",
      options = { desc = "Run to cursor", silent = true },
    },
    {
      action = "<cmd>lua require('dap').goto_()<cr>",
      key = "<leader>dg",
      mode = "n",
      options = { desc = "Go to line (no execute)", silent = true },
    },
    { action = ":DapStepInto<cr>", key = "<leader>di", mode = "n", options = { desc = "Step into", silent = true } },
    {
      action = "\n        <cmd>lua require('dap').down()<cr>\n      ",
      key = "<leader>dj",
      mode = "n",
      options = { desc = "Down", silent = true },
    },
    {
      action = "<cmd>lua require('dap').up()<cr>",
      key = "<leader>dk",
      mode = "n",
      options = { desc = "Up", silent = true },
    },
    {
      action = "<cmd>lua require('dap').run_last()<cr>",
      key = "<leader>dl",
      mode = "n",
      options = { desc = "Run Last", silent = true },
    },
    { action = ":DapStepOut<cr>",  key = "<leader>do", mode = "n", options = { desc = "Step Out", silent = true } },
    { action = ":DapStepOver<cr>", key = "<leader>dO", mode = "n", options = { desc = "Step Over", silent = true } },
    {
      action = "<cmd>lua require('dap').pause()<cr>",
      key = "<leader>dp",
      mode = "n",
      options = { desc = "Pause", silent = true },
    },
    {
      action = ":DapToggleRepl<cr>",
      key = "<leader>dr",
      mode = "n",
      options = { desc = "Toggle REPL", silent = true },
    },
    {
      action = "<cmd>lua require('dap').session()<cr>",
      key = "<leader>ds",
      mode = "n",
      options = { desc = "Session", silent = true },
    },
    {
      action = ":DapTerminate<cr>",
      key = "<leader>dt",
      mode = "n",
      options = { desc = "Terminate", silent = true },
    },
    {
      action = "<cmd>lua require('dapui').toggle()<cr>",
      key = "<leader>du",
      mode = "n",
      options = { desc = "Dap UI", silent = true },
    },
    {
      action = "<cmd>lua require('dap.ui.widgets').hover()<cr>",
      key = "<leader>dw",
      mode = "n",
      options = { desc = "Widgets", silent = true },
    },
    {
      action = "<cmd>lua require('dapui').eval()<cr>",
      key = "<leader>de",
      mode = { "n", "v" },
      options = { desc = "Eval", silent = true },
    },
    {
      action = "<cmd>BufferLineCycleNext<cr>",
      key = "<Tab>",
      mode = "n",
      options = { desc = "Cycle to next buffer" },
    },
    {
      action = "<cmd>BufferLineCyclePrev<cr>",
      key = "<S-Tab>",
      mode = "n",
      options = { desc = "Cycle to previous buffer" },
    },
    {
      action = "<cmd>BufferLineCycleNext<cr>",
      key = "<S-l>",
      mode = "n",
      options = { desc = "Cycle to next buffer" },
    },
    {
      action = "<cmd>BufferLineCyclePrev<cr>",
      key = "<S-h>",
      mode = "n",
      options = { desc = "Cycle to previous buffer" },
    },
    { action = "<cmd>bdelete<cr>", key = "<leader>bd", mode = "n", options = { desc = "Delete buffer" } },
    { action = "<cmd>e #<cr>",     key = "<leader>bb", mode = "n", options = { desc = "Switch to Other Buffer" } },
    {
      action = "<cmd>BufferLineCloseRight<cr>",
      key = "<leader>br",
      mode = "n",
      options = { desc = "Delete buffers to the right" },
    },
    {
      action = "<cmd>BufferLineCloseLeft<cr>",
      key = "<leader>bl",
      mode = "n",
      options = { desc = "Delete buffers to the left" },
    },
    {
      action = "<cmd>BufferLineCloseOthers<cr>",
      key = "<leader>bo",
      mode = "n",
      options = { desc = "Delete other buffers" },
    },
    { action = "<cmd>BufferLineTogglePin<cr>", key = "<leader>bp",    mode = "n",         options = { desc = "Toggle pin" } },
    {
      action = "<Cmd>BufferLineGroupClose ungrouped<CR>",
      key = "<leader>bP",
      mode = "n",
      options = { desc = "Delete non-pinned buffers" },
    },
    {
      action = "<Nop>",
      key = "<Up>",
      mode = { "n", "i" },
      options = { desc = "Disable Up arrow key", noremap = true, silent = true },
    },
    {
      action = "<Nop>",
      key = "<Down>",
      mode = { "n", "i" },
      options = { desc = "Disable Down arrow key", noremap = true, silent = true },
    },
    {
      action = "<Nop>",
      key = "<Right>",
      mode = { "n", "i" },
      options = { desc = "Disable Right arrow key", noremap = true, silent = true },
    },
    {
      action = "<Nop>",
      key = "<Left>",
      mode = { "n", "i" },
      options = { desc = "Disable Left arrow key", noremap = true, silent = true },
    },
    { action = "+find/file",                   key = "<leader>f",     mode = "n" },
    { action = "+search",                      key = "<leader>s",     mode = "n" },
    { action = "+quit/session",                key = "<leader>q",     mode = "n" },
    { action = "+git",                         key = "<leader>g",     mode = { "n", "v" } },
    { action = "+ui",                          key = "<leader>u",     mode = "n" },
    { action = "+windows",                     key = "<leader>w",     mode = "n" },
    { action = "+tab",                         key = "<leader><Tab>", mode = "n" },
    { action = "+debug",                       key = "<leader>d",     mode = { "n", "v" } },
    { action = "+code",                        key = "<leader>l",     mode = { "n", "v" } },
    { action = "+test",                        key = "<leader>t",     mode = { "n", "v" } },
    {
      action = "<cmd>tablast<cr>",
      key = "<leader><tab>l",
      mode = "n",
      options = { desc = "Last tab", silent = true },
    },
    {
      action = "<cmd>tabfirst<cr>",
      key = "<leader><tab>f",
      mode = "n",
      options = { desc = "First Tab", silent = true },
    },
    {
      action = "<cmd>tabnew<cr>",
      key = "<leader><tab><tab>",
      mode = "n",
      options = { desc = "New Tab", silent = true },
    },
    {
      action = "<cmd>tabnext<cr>",
      key = "<leader><tab>]",
      mode = "n",
      options = { desc = "Next Tab", silent = true },
    },
    {
      action = "<cmd>tabclose<cr>",
      key = "<leader><tab>d",
      mode = "n",
      options = { desc = "Close tab", silent = true },
    },
    {
      action = "<cmd>tabprevious<cr>",
      key = "<leader><tab>[",
      mode = "n",
      options = { desc = "Previous Tab", silent = true },
    },
    { action = "<C-W>p",          key = "<leader>ww", mode = "n", options = { desc = "Other window", silent = true } },
    { action = "<C-W>c",          key = "<leader>wd", mode = "n", options = { desc = "Delete window", silent = true } },
    { action = "<C-W>c",          key = "<leader>wq", mode = "n", options = { desc = "Delete window", silent = true } },
    { action = "<C-W>s",          key = "<leader>w-", mode = "n", options = { desc = "Split window below", silent = true } },
    { action = "<C-W>s",          key = "\\",         mode = "n", options = { desc = "Split window below", silent = true } },
    { action = "<C-W>v",          key = "<leader>w|", mode = "n", options = { desc = "Split window right", silent = true } },
    { action = "<C-W>v",          key = "|",          mode = "n", options = { desc = "Split window right", silent = true } },
    { action = "gcc",             key = "<leader>c",  mode = "n", options = { desc = "Comment", silent = true } },
    { action = "<cmd>w<cr><esc>", key = "<C-s>",      mode = "n", options = { desc = "Save file", silent = true } },
    {
      action = "<cmd>quitall<cr><esc>",
      key = "<leader>qq",
      mode = "n",
      options = { desc = "Quit all", silent = true },
    },
    {
      action = ":lua require('persistence').load()<cr>",
      key = "<leader>qs",
      mode = "n",
      options = { desc = "Restore session", silent = true },
    },
    {
      action = "<cmd>lua require('persistence').load({ last = true })<cr>",
      key = "<leader>ql",
      mode = "n",
      options = { desc = "Restore last session", silent = true },
    },
    {
      action = "<cmd>lua require('persistence').stop()<cr>",
      key = "<leader>qd",
      mode = "n",
      options = { desc = "Don't save current session", silent = true },
    },
    {
      action = ":lua ToggleLineNumber()<cr>",
      key = "<leader>ul",
      mode = "n",
      options = { desc = "Toggle Line Numbers", silent = true },
    },
    {
      action = ":lua ToggleRelativeLineNumber()<cr>",
      key = "<leader>uL",
      mode = "n",
      options = { desc = "Toggle Relative Line Numbers", silent = true },
    },
    {
      action = ":lua ToggleWrap()<cr>",
      key = "<leader>uw",
      mode = "n",
      options = { desc = "Toggle Line Wrap", silent = true },
    },
    {
      action = ":m '>+1<CR>gv=gv",
      key = "J",
      mode = "v",
      options = { desc = "Move up when line is highlighted", silent = true },
    },
    {
      action = ":m '<-2<CR>gv=gv",
      key = "K",
      mode = "v",
      options = { desc = "Move down when line is highlighted", silent = true },
    },
    {
      action = "mzJ`z",
      key = "J",
      mode = "n",
      options = { desc = "Allow cursor to stay in the same place after appeding to current line", silent = true },
    },
    {
      action = "<gv",
      key = "<",
      mode = "v",
      options = { desc = "Indent while remaining in visual mode.", silent = true },
    },
    {
      action = ">gv",
      key = ">",
      mode = "v",
      options = { desc = "Indent while remaining in visual mode.", silent = true },
    },
    {
      action = "<C-d>zz",
      key = "<C-d>",
      mode = "n",
      options = { desc = "Allow <C-d> and <C-u> to keep the cursor in the middle", silent = true },
    },
    {
      action = "<C-u>zz",
      key = "<C-u>",
      mode = "n",
      options = { desc = "Allow C-d and C-u to keep the cursor in the middle" },
    },
    {
      action = [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']],
      key = "j",
      mode = "n",
      options = { desc = "Remap for dealing with word wrap and adding jumps to the jumplist.", expr = true },
    },
    {
      action = [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']],
      key = "k",
      mode = "n",
      options = { desc = "Remap for dealing with word wrap and adding jumps to the jumplist.", expr = true },
    },
    { action = "nzzzv", key = "n", mode = "n", options = { desc = "Allow search terms to stay in the middle" } },
    { action = "Nzzzv", key = "N", mode = "n", options = { desc = "Allow search terms to stay in the middle" } },
    {
      action = '"_dP',
      key = "<leader>p",
      mode = "x",
      options = { desc = "Deletes to void register and paste over" },
    },
    { action = '"+y', key = "<leader>y", mode = { "n", "v" }, options = { desc = "Copy to system clipboard" } },
    { action = '"+Y', key = "<leader>Y", mode = { "n", "v" }, options = { desc = "Copy to system clipboard" } },
    { action = '"_d', key = "<leader>D", mode = { "n", "v" }, options = { desc = "Delete to void register" } },
    -- { action = "<Esc>", key = "<C-c>",     mode = "i" },
  }
  for i, map in ipairs(__nixvim_binds) do
    vim.keymap.set(map.mode, map.key, map.action, map.options)
  end
end
-- }}}
