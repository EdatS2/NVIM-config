local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Settings for LSPs
vim.lsp.config("ltex", {
    filetypes = { 'bib', 'gitcommit', 'markdown', 'org', 'plaintex', 'rst', 'rnoweb', 'tex', 'pandoc', 'quarto', 'rmd', 'context', 'html', 'xhtml', 'mail', 'text' },
    settings = {
        additionalRules = {
            enablePickyRules = true,
        },
    },
})
vim.lsp.enable("ltex")
vim.lsp.config("clangd", { capabilities = capabilities, cmd = { "clangd", "-header-insertion=never" }, filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' } })
-- vim.lsp.config("nixd", { capabilities = capabilities, filetypes = { 'nix' } })
-- vim.lsp.config("bashls", { capabilities = capabilities, filetypes = { 'bash', 'sh' } })
-- -- lspconfig.jedi_language_server.setup{capabilities=capabilities}
-- vim.lsp.config("pyright") 
-- vim.lsp.config("lua_ls", { capabilities = capabilities, filetypes = { 'lua' } })
-- vim.lsp.config("texlab", { capabilities = capabilities, filetypes = { 'tex', 'plaintex', 'bib' } })
-- vim.lsp.config("zls", { capabilities = capabilities, filetypes = { 'zig', 'zir' } })
-- vim.lsp.config("marksman", { capabilities = capabilities, filetypes = { 'markdown', 'markdown.mdx' } })
vim.lsp.config("typescript-language-server", { capabilities = capabilities, cmd = { "typescript-language-server", "--stdio" }, filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } })
vim.lsp.enable({'clangd','nixd','bashls','pyright','lua_ls','zls','texlab','marksman','typescript-language-server'})

-- cmp setup
local cmp = require('cmp')

cmp.setup({
    sources = cmp.config.sources({
        { name = 'path', priority = 1250 },
        { name = 'omni', priority = 1250 },
        { name = 'nvim_lsp', priority = 750 },
        { name = 'luasnip', priority = 500 },
        { name = 'codecompanion', priority = 950 },
    }),
    mapping = cmp.mapping.preset.insert({
        -- Confirm completion
--        ['<Tab>'] = cmp.mapping.confirm({select = true}),

        -- Trigger completion menu
        ['<A-Enter>'] = cmp.mapping.complete(),

        -- -- Navigate between snippet placeholders
        -- ['<C-f>'] = cmp.mapping(cmp_action.luasnip_jump_forward(), {"i","s"}),
        -- ['<C-b>'] = cmp.mapping(cmp_action.luasnip_jump_backward(), {"i","s"}),

        -- Scroll through completions
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    }),
    snippet = {
        expand = function(args)
        -- require('luasnip').lsp_expand(args.body)
        vim.snippet.expand(args.body)
    end,
},
})

-- vim.lsp.on_attach(function(client, bufnr)
--     local opts = {buffer = bufnr, remap = false}
--     vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
--     vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
--     vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format() end, opts)
--     vim.keymap.set('n', '<leader>rn', function ()
--         vim.lsp.buf.rename()
--     end, opts)
-- end)
--
-- vim.lsp.setup()
