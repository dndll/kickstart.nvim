# Bead: CodeLLDB Debugger for Rust with Nix/Home-Manager

**Status:** pending
**Priority:** high
**Complexity:** medium
**Tags:** rust, debugging, nix, home-manager

## Problem

The Neovim config has extensive DAP (Debug Adapter Protocol) keybindings configured in `keymaps.lua` (`<leader>d*`), but the debug setup in `debug.lua` only configures Go debugging via `delve`. Rust debugging is non-functional.

For heavy Rust development, this is a major capability gap. Users are forced into "println! debugging" instead of proper breakpoints, stepping, and variable inspection.

## Solution

Integrate CodeLLDB debug adapter for Rust via rustaceanvim's built-in DAP support.

## Challenge: Nix/Home-Manager Paths

On the main system, dependencies are managed via Nix and home-manager. This creates path complexity:

1. **Mason paths won't work** - Mason installs to `~/.local/share/nvim/mason/bin/codelldb` but on Nix systems, binaries come from the Nix store
2. **Nix store paths are dynamic** - Paths like `/nix/store/abc123-codelldb/bin/codelldb` change on updates
3. **Need conditional logic** - Config should work on both Nix and non-Nix systems

## Implementation Plan

### Option A: Detect Nix and use different paths

```lua
local function get_codelldb_path()
    -- Try Nix path first (via home-manager)
    local nix_path = vim.fn.exepath('codelldb')
    if nix_path ~= '' then
        return nix_path
    end
    -- Fall back to Mason path
    return vim.fn.stdpath('data') .. '/mason/bin/codelldb'
end
```

### Option B: Home-manager module integration

Add to home-manager config:
```nix
programs.neovim = {
  extraPackages = with pkgs; [
    lldb
    vscode-extensions.vadimcn.vscode-lldb  # CodeLLDB
  ];
};
```

Then use `vim.fn.exepath('codelldb')` which will find it in PATH.

### Option C: Environment variable

Set `CODELLDB_PATH` in home-manager and reference it:
```lua
local codelldb = os.getenv('CODELLDB_PATH') or vim.fn.stdpath('data') .. '/mason/bin/codelldb'
```

## Files to Modify

1. **`lua/kickstart/plugins/debug.lua`**
   - Add `codelldb` to mason-nvim-dap ensure_installed (for non-Nix systems)
   - Add conditional path detection

2. **`lua/custom/plugins/activated/rustaceanvim.lua`**
   - Configure DAP adapter with dynamic path resolution

3. **Home-manager config** (separate repo)
   - Ensure codelldb is available in PATH

## Example rustaceanvim DAP Config

```lua
return {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    init = function()
        local codelldb_path = vim.fn.exepath('codelldb')
        if codelldb_path == '' then
            codelldb_path = vim.fn.stdpath('data') .. '/mason/bin/codelldb'
        end

        vim.g.rustaceanvim = vim.tbl_deep_extend('force', vim.g.rustaceanvim or {}, {
            dap = {
                adapter = {
                    type = 'server',
                    port = '${port}',
                    executable = {
                        command = codelldb_path,
                        args = { '--port', '${port}' },
                    },
                },
            },
        })
    end,
}
```

## Acceptance Criteria

- [ ] `<leader>db` sets breakpoints in Rust code
- [ ] `<leader>dc` starts/continues Rust debugging
- [ ] `:RustLsp debuggables` shows runnable debug targets
- [ ] Variable inspection works in DAP UI
- [ ] Works on both Nix (main system) and non-Nix (server) systems

## Notes

- Test on server first (non-Nix) to verify basic DAP config works
- Then adapt for Nix paths on main system
- Consider making this a toggleable/optional feature for kickstart users who don't use Rust
