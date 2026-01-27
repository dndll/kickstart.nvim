-- crates.nvim: Cargo.toml dependency management
-- Shows inline version info, completion, and one-key updates
return {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        completion = {
            cmp = { enabled = true }, -- blink.cmp via compat layer
        },
        lsp = {
            enabled = true,
            actions = true,
            hover = true,
            completion = true,
        },
    },
    keys = {
        { '<leader>ct', function() require('crates').toggle() end, desc = 'Toggle crates info' },
        { '<leader>cr', function() require('crates').reload() end, desc = 'Reload crates' },
        { '<leader>cu', function() require('crates').upgrade_crate() end, desc = 'Upgrade crate' },
        { '<leader>cU', function() require('crates').upgrade_all_crates() end, desc = 'Upgrade all crates' },
        { '<leader>cd', function() require('crates').open_documentation() end, desc = 'Open docs.rs' },
        { '<leader>cc', function() require('crates').open_crates_io() end, desc = 'Open crates.io' },
        { '<leader>cf', function() require('crates').show_features_popup() end, desc = 'Show features' },
        { '<leader>cv', function() require('crates').show_versions_popup() end, desc = 'Show versions' },
    },
}
