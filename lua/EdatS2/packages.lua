-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--     vim.fn.system({
--         "git",
--         "clone",
--         "--filter=blob:none",
--         "https://github.com/folke/lazy.nvim.git",
--         "--branch=stable", -- latest stable release
--         lazypath,
--     })
-- end
require("lazy").setup(lazyPackages, {
   performance = {
     reset_packpath = false, -- so that plugins outside of lazy can be loaded
   },
 })
 vim.cmd("packloadall") -- load plugins outside of lazy

local plugins = {
}

local opts = {}

-- require("lazy").setup(plugins, opts)
