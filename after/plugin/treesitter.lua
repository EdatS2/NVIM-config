-- nvim-treesitter `main` branch: setup() no longer handles highlighting.
-- Parsers are provided by nix; enable highlighting per-buffer via vim.treesitter.start().
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    -- starts TS highlighting wherever a parser exists; silently skips filetypes without one
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Hyprland config syntax highlighting
vim.filetype.add({
  pattern = { ["hyprland.conf"] = "hyprlang" },
})
