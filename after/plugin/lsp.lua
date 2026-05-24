local lsp = require('lsp-zero')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp.preset('recommended')


-- Settings for LSPs
vim.lsp.config("ltex", {
    settings = {
        additionalRules = {
            enablePickyRules = true,
        },
    },
})
vim.lsp.enable("ltex")
vim.lsp.config("clangd",{capabilities=capabilities, cmd={ "clangd", "-header-insertion=never"}})
vim.lsp.enable("clangd")
vim.lsp.config("nixd",{capabilities=capabilities})
vim.lsp.enable("nixd")
vim.lsp.config("bashls",{capabilities=capabilities, filetypes = { 'sh' }})
vim.lsp.enable("bashls")
-- lspconfig.jedi_language_server.setup{capabilities=capabilities}
vim.lsp.config("pyright",{capabilities=capabilities})
vim.lsp.enable("pyright")
vim.lsp.config("lua_ls",{capabilities=capabilities})
vim.lsp.enable("lua_ls")
vim.lsp.config("texlab",{capabilities=capabilities})
vim.lsp.enable("texlab")
vim.lsp.config("zls",{capabilities=capabilities})
vim.lsp.enable("zls")
vim.lsp.config("marksman",{capabilities=capabilities})
vim.lsp.enable("marksman")
vim.lsp.enable("typescript-language-server")
vim.lsp.config("typescript-language-server", {capabilities=capabilities, cmd={ "typescript-language-server", "--stdio"}})

-- cmp setup
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

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

        -- Navigate between snippet placeholders
        ['<C-f>'] = cmp.mapping(cmp_action.luasnip_jump_forward(), {"i","s"}),
        ['<C-b>'] = cmp.mapping(cmp_action.luasnip_jump_backward(), {"i","s"}),

        -- Scroll through completions
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    }),
    snippet = {
        expand = function(args)
        require('luasnip').lsp_expand(args.body)
    end,
},
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev)
    vim.keymap.set('n', '<leader>lo', vim.diagnostic.setloclist)
    vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format() end, opts)
    vim.keymap.set('n', '<leader>rn', function ()
        vim.lsp.buf.rename()
    end, opts)
end)

lsp.setup()
